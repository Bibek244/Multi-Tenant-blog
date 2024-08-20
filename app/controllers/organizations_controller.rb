class OrganizationsController < ApplicationController
  before_action :set_organization, only: %i[ show edit update destroy ]
  before_action :authorize_member, only: %i[ show edit update destroy ]
  before_action :authorize_su?, only: [:create]
  helper_method :authorize_su?

  def index
    @organizations = current_user.organizations
  end

  def show
  end

  def new
    @organization = Organization.new
  end

  def edit
  end

  def create
    service = ::OrganizationAdder::CsvImportService.new
   service.execute
      if service.success 
      redirect_to organizations_path, notice: "successfully created organization from csv. " 
      else
      redirect_to organizations_path, alert: service.error
      end
    
  end

  def update
    if @organization.update(organization_params)
      redirect_to organization_url(@organization), notice: "organization was successfully updated." 
    else
      render :edit, alert: "Failed to update organization"
    end
  end

  
  def destroy
    @organization.destroy
    redirect_to organization_url, notice: "organization was successfully destroyed."
  end

  private

    def authorize_member
      redirect_to root_path, alert: 'You are not a member' unless @organization.users.include? current_user
    end

    def set_organization
      @organization = Organization.find(params[:id])
    end
    
    def organization_params
      params.require(:organization).permit(:name)
    end

    def authorize_su?
      user = User.find_by(id: current_user.id)
      user&.is_su?
    end
end

