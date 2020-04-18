class User::MessagesController < ApplicationController
  def show
  end

  def create
    @room = Room.create(:name => "DM")
    redirect_to room_path(@room.id)
  end
end
