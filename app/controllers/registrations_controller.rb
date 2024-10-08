class RegistrationsController < Devise::RegistrationsController
  def create
    
    debugger
    service = Users::UserRegistrationService.new(params).execute
    
    if service.success?
      redirect_to new_user_session_path, notice: 'Successfully signed in!'
    else
      flash[:alert] = service.errors
      redirect_to new_user_session_path(:user)
    end
  end
  
end


# user = User.find_by(email: params[:user][:email])
    # if user.present?
    #   organization = Organization.find_by(id: params[:user][:organization_id])

    #   if user.valid_password?(params[:user][:password])
    #     Membership.find_or_create_by(user: user, organization: organization)
    #     sign_in_and_redirect user,  notice: "successfully added #{user.email} to #{organization.name}"
    #   else
    #     redirect_to new_user_registration_url(organization_id: organization.id, organization_name: organization.name, email: user.email), alert: 'incorrect password for the existing user'
    #   end

    # else
    #   @user = User.new(signup_params)
    #   @organization = Organization.find_by(id: params[:user][:organization_id])

    #   if @organization.present?
    #     if @user.save
    #       Membership.find_or_create_by(user: @user, organization: @organization)
    #       flash[:notice] = "You've been added to the organization."
    #       sign_in_and_redirect @user, event: :authentication
    #     else
    #       render :new
    #     end
    #   else
    #     super
    #   end
    # end