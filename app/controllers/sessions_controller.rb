# app/controllers/users/sessions_controller.rb
class SessionsController < Devise::SessionsController
  def create
    user = User.find_by(email: params[:user][:email])

    if user && user.valid_password?(params[:user][:password])
      if user.memberships.exists?(organization_id: params[:organization_id])
        sign_in(:user, user)
        session[:organization_id] = params[:organization_id]
        redirect_to after_sign_in_path_for(user), notice: 'Successfully signed in!'
      else
        flash[:alert] = "You do not belong to the selected organization."
        redirect_to new_session_path(:user)
      end
    else
      flash[:alert] = "Invalid email, password, or organization."
      redirect_to new_session_path(:user)
    end
  end
end
