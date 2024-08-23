class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[ new show edit ]
  before_action :authorize_user, only: %i[ show edit update ]


  def new
    if !@profile.nil?
      redirect_to profile_path(@profile)
    end
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
      if @profile.save
        flash[:notice] = "Profile created successfully."
        redirect_to profile_path(@profile) and return
      else
        flash[:alert] = "Failed to create profile."
        redirect_to root_path and return
      end
  end

  def show
    if @profile.nil?
      redirect_to new_profile_path
    end
  end

  def edit
  end


  def update
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to profile_path(@profile), notice: "Profile was successfully updated." }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_profile
      @profile = Profile.find_by(user: current_user)
      
    end

    def authorize_user
      if @profile.present? && @profile.user != current_user
        redirect_to root_path, alert: "You are not authorized to access this profile."
      end
    end

    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :email, :address, :avatar)
    end
end
