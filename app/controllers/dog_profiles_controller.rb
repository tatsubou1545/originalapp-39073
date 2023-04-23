class DogProfilesController < ApplicationController
  before_action :move_to_index
  before_action :set_params, only: [:edit, :update, :destroy]
  before_action :compare_id, only: [:edit]
  before_action :error_messsage_reset
  before_action :set_date, only: [:create, :update]
  before_action :create_date_check, only: [:create]
  before_action :update_date_check, only: [:update]

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
    if @dog_profile.update(profile_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def destroy
    if @dog_profile.destroy
      redirect_to user_path(current_user.id)
    else
      redirect_to user_path(current_user.id)
    end
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

  def error_messsage_reset
    flash.clear
  end

  def set_date
    @year = params[:dog_profile]["dog_birthday(1i)"].to_i
    @month = params[:dog_profile]["dog_birthday(2i)"].to_i
    @day = params[:dog_profile]["dog_birthday(3i)"].to_i
  end

  def create_date_check
    @dog_profile = DogProfile.new(profile_params)
    if @year.zero? || @month.zero? || @day.zero?
      if (@year.zero? && @month.zero? && @day.zero?) && @dog_profile.save
        redirect_to user_path(current_user.id)
      elsif @year.zero? && @month.zero? && @day.zero?
        render :new
      else
        flash[:dog_create_error] = "日付が正しくありません"
        render :new
      end
      return
    end

    begin
      dog_birthday = Date.new(@year, @month, @day)
    rescue ArgumentError, TypeError
      flash[:dog_create_error] = "存在しない日付が入力されています"
      render :new
      return
    end

    dog_birthday = Date.new(@year, @month, @day)
    if dog_birthday > Date.today
      flash[:dog_create_error] = "日付が未来日です"
      render :new
      return
    end
  end

  def update_date_check
    if @year.zero? || @month.zero? || @day.zero?
      if (@year.zero? && @month.zero? && @day.zero?) && @dog_profile.update(profile_params)
        redirect_to user_path(current_user.id)
      elsif @year.zero? && @month.zero? && @day.zero?
        render :edit
      else
        flash[:dog_update_error] = "正しい日付を入力してください"
        render :edit
      end
      return
    end

    begin
      dog_birthday = Date.new(@year, @month, @day)
    rescue ArgumentError, TypeError
      flash[:dog_update_error] = "存在しない日付が入力されています"
      render :edit
      return
    end

    dog_birthday = Date.new(@year, @month, @day)
    if dog_birthday > Date.today
      flash[:dog_update_error] = "日付が未来日です"
      render :edit
      return
    end
  end
end
