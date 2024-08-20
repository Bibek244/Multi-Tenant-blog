module OrganizationAdder
  class CsvImportService
    require 'csv'

    attr_reader :success, :errors

    def initialize
      @success = false
      @errors = []
    end

    def execute
      call
      self
    end

    def success?
      @success && @errors.empty?
    end

    def call
      csv_file_path = Rails.root.join('lib', 'csvs', 'organization.csv')
      options = { headers: true, col_sep: ',' }
      organization_array = []

      CSV.foreach(csv_file_path, **options) do |row|
        organization_array << {
          organization_name: row['organization_name'],
          organization_email: row['organization_email']
        }
      end

      ActiveRecord::Base.transaction do
        organization_array.each do |org_data|
          existing_user = User.find_by(email: org_data[:organization_email])

          if existing_user
            @errors << "User with email #{org_data[:organization_email]} already exists. Skipping."
            next 
          end

          user = User.new(email: org_data[:organization_email], password: 'password', password_confirmation: 'password')

          unless user.save
            @errors << "Failed to save user #{org_data[:organization_email]}: #{user.errors.full_messages.join(', ')}"
            raise ActiveRecord::Rollback
          end

          organization = Organization.find_or_create_by(name: org_data[:organization_name])

          if organization.persisted?
            membership = Membership.find_or_initialize_by(user_id: user.id, organization_id: organization.id)
            membership.is_admin = true

            unless membership.save
              @errors << "Failed to create membership for user #{user.email}: #{membership.errors.full_messages.join(', ')}"
              raise ActiveRecord::Rollback
            end
          else
            @errors << "Failed to save organization #{org_data[:organization_name]}: #{organization.errors.full_messages.join(', ')}"
            raise ActiveRecord::Rollback
          end
        end
        @success = true
      end
    rescue ActiveRecord::Rollback
      @success = false
    end
  end
end
