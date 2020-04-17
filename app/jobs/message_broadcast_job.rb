class MessageBroadcastJob < ApplicationJob
	# このファイルは不要
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "room_channel_#{message.room_id}", message: render_message(message)
  end

  private

  def render_message(message)
    ApplicationController.renderer.render partial: 'user/messages/message', locals: { message: message }
  end
end
