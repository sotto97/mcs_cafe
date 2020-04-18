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
    @messages = @room.messages.recent.reverse
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_path
  end

  private
  def room_params
    params.permit(:name, :guest_user_id, :host_user_id)
  end
end
