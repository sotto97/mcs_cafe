class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :body, presence: true
  scope :recent, -> { order(created_at: :desc)}

  #ブロードキャスト 非同期通信に必要
  # after_create_commit { MessageBroadcastJob.perform_later self }
 end
