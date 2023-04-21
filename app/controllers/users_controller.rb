class UsersController < ApplicationController
  before_action :move_to_index
  before_action :set_params, only: [:show, :update, :edit]
  before_action :compare_id, only: [:edit]

  def show
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def edit
  end


  private

  def move_to_index
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
  
  def user_params
    params.require(:user).permit(:nickname, :email, :user_profile, :dog_breed, :dog_number, :dog_birthday, :dog_profile, :image)
  end

  def set_params
    @user = User.find(params[:id])
  end

  def compare_id
    unless current_user.id == @user.id
      redirect_to root_path 
    end
  end
end
