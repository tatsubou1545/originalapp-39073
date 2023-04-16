class RoomsController < ApplicationController

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

  private

  def room_params
    params.require(:room).permit(:name)
  end

end