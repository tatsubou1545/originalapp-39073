class RoomsController < ApplicationController
  before_action :move_to_index, only: [:index, :show]
  before_action :set_params, only: [:destroy, :add_user, :show]
  before_action :check_id, only: [:show]

  def index
    @rooms = Room.all
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      @room.users << current_user
      redirect_to room_messages_path(@room)
    else
      redirect_to root_path
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_path
  end

  def show
  end

  def add_user
    if params[:room][:user_id] != ''
      user = User.find(params[:room][:user_id])
      if @room.users.include?(user)
        redirect_to room_path(@room)
      else
        @room.users << user
        redirect_to room_messages_path(@room) 
      end
    else
      redirect_to room_path(@room)
    end
  end

  private

  def room_params
    if params[:room].present?
      params.require(:room).permit(:name)
    else
      { name: params[:name] }
    end
  end

  def set_params
    @room = Room.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def check_id
    unless @room && @room.users.exists?(id: current_user.id)
      redirect_to root_path 
    end
  end
end