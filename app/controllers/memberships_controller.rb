class MembershipsController < AuthorizedController
  before_action :authorize_admin, only: [:create]
  helper_method :authorize_admin

  include InvitationsSender

  def index
    @members = @organization.users if @organization = Organization.find(params[:organization_id])
  end

  def create

    @email = params[:email]
    puts @email
    @current_organization = Organization.find_by(id: params[:organization_id])
    return redirect_to organization_memberships_path(@current_organization) if @email.blank?

  end

  private
  def authorize_admin
    membership = Membership.find_by(user: current_user, organization: @current_organization)
     membership&.is_admin?
  end
  

end
