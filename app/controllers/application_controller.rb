class ApplicationController < ActionController::Base
  before_action :authenticate_user! 

  helper_method :current_organization

  private
  def current_organization
    session[:organization_id] if user_signed_in?
  end
end
