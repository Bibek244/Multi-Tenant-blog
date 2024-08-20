class ApplicationController < ActionController::Base
  before_action :authenticate_user! 

  helper_method :current_organization

  private
  def current_organization
    current_user.organizations.first if user_signed_in?
  end
end
