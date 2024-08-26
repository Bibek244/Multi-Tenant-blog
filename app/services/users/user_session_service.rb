module Users
  class UserSessionService
    attr_reader :params, :user
    attr_accessor :success, :errors

    def initialize(params={})
    @params = params
    @success = false
    @errors = []
    end

    def success?
      @success 
    end

    def errors 
      @errors.join(', ')
    end
  
    def execute
      call
      self
    end

    private

      def call
        User.transaction do
          user = User.find_by(email: @params[:email])
          raise ActiveRecord::RecordNotFound, "User not found with the provided email: #{@params[:email]}" if user.nil?
          if user.valid_password?(@params[:password])
            if user.memberships.exists?(organization_id: @params[:organization_id])
              @success = true
              @user = user
            else
              if user.is_su
                @success = true
                @user = user
              else
                raise StandardError.new("You do not belong to the selected organization.")
              end
            end
          else
            raise StandardError.new("Invalid email, password, or organization.")
          end
        end
        rescue ActiveRecord::RecordNotFound, StandardError => e
          @success = false
          @errors << e.message
      end
  end
end