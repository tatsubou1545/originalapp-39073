class MessagesController < ApplicationController
  before_action :move_to_index, only: [:index]
  before_action :set_params, only: [:index, :create]
  before_action :check_id, only: [:index]

  def index
    @message = Message.new
    @messages = @room.messages.order("created_at DESC").includes(:user)
    @rooms = Room.all
  end

  def create
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
      redirect_to room_messages_path(@room)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def set_params
    @room = Room.find(params[:room_id])
  end

  def check_id
    unless @room && @room.users.exists?(id: current_user.id)
      redirect_to root_path
    end
  end
end
