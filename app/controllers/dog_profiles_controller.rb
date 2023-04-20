class DogProfilesController < ApplicationController
  before_action :move_to_index
  before_action :set_params, only: [:edit, :update, :destroy]
  before_action :compare_id, only: [:edit]

  def new
    @dog_profile = DogProfile.new
  end

  def create
    @dog_profile = DogProfile.new(profile_params)
    if @dog_profile.save
      redirect_to user_path(current_user.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private
  
  def profile_params
    params.require(:dog_profile).permit(:dog_breed, :dog_birthday, :dog_profile, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def set_params
    @dog_profile = DogProfile.find(params[:id])
  end

  def compare_id
    unless current_user.id == @dog_profile.user_id
      redirect_to user_path(current_user.id)
    end
  end
end
