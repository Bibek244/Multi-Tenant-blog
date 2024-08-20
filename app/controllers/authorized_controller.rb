class AuthorizedController < ApplicationController
  before_action :set_current_organizaton
  before_action :authorize_member

  private

  def set_current_organizaton
  @current_organization = Organization.find_by(id: params[:organization_id])
  end
  
  def authorize_member
    redirect_to root_path, alert: 'You are not a member' unless @current_organization.users.include? current_user
  end
end