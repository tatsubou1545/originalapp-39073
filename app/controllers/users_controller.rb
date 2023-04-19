class UsersController < ApplicationController
  before_action :set_params, only: [:show, :update, :edit]

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
  
  def user_params
    params.require(:user).permit(:nickname, :email, :user_profile, :dog_breed, :dog_number, :dog_birthday, :dog_profile, :image)
  end

  def set_params
    @user = User.find(params[:id])
  end
  
end
