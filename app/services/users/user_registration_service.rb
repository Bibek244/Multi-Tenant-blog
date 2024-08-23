module Users
  class UserRegistrationService
    attr_reader :params, :user, :organization
    attr_accessor :success, :errors

    def initialize(params = {})
      @params = params
      @success = false
      @errors = []
    end

    def success?
      @success && @errors.empty?
    end

    def errors
      @errors.join(", ")
    end

    def execute
      call
      self
    end

    private

      def call
        ActiveRecord::Base.transaction do
          @user = User.find_by(email: params[:user][:email])

          if @user && @user.valid_password?(params[:user][:password])
            find_organization
            Membership.find_or_create_by!(user: @user, organization: @organization)
          else
            @user = User.new(signup_params)
             @user.save
              find_organization
              Membership.find_or_create_by!(user: @user, organization: @organization)
          end

          @success = true
        end
      rescue => e
        @success = false
        @errors << e.message
        raise ActiveRecord::Rollback
      end

      def find_organization
          # raise StandardError.new("Organization ID is missing!") if params[:user][:organization_id].blank?
          @organization = Organization.find_by(id: params[:user][:organization_id])
          # raise StandardError.new("Organization not found!")  unless @organization
      end

      def signup_params
        @params.require(:user).permit(:email, :password, :password_confirmation)
      end
  end
end
