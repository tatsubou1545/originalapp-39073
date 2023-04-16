class RoomsController < ApplicationController

  def create
    @room = Room.new(room_params)
    if @room.save
      @room.users << current_user
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end

end