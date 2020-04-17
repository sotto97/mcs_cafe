class User::RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def create
    @room = Room.new(room_params)
    @room.save
    redirect_to room_path(@room)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.recent.limit(5).reverse
  end

  private
  def room_params
    params.permit(:name, :user_id)
  end
end
