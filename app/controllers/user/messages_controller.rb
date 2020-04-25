class User::MessagesController < ApplicationController
  before_action :authenticate_user!
  def show
  end

  def create
    @room = Room.create(:name => "DM")
    redirect_to room_path(@room.id)
  end
end
