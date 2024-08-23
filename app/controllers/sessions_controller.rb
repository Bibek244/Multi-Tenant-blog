# app/controllers/users/sessions_controller.rb
class SessionsController < Devise::SessionsController
  def create
    service = Users::UserSessionService.new(
      email: params[:user][:email],
      password: params[:user][:password],
      organization_id: params[:organization_id]
    )
    service.execute

    if service.success?
      sign_in(:user, service.user)
      session[:organization_id] = params[:organization_id]
      redirect_to after_sign_in_path_for(service.user), notice: 'Successfully signed in!'
    else
      flash[:alert] = service.errors
      redirect_to new_session_path(:user)
    end
  end
end
