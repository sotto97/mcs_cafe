class User::MessagesController < ApplicationController
  def show
  end

  def create
    @room = Room.create(:name => "DM")
    #entryにログインユーザーを作成
    @entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id)
    #entryにparamsユーザーを作成
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(:room_id => @room.id))
    redirect_to room_path(@room.id)
  end
end
