class Room < ApplicationRecord
	has_many :messages, dependent: :destroy

	belongs_to :host_user, class_name: "User"
	belongs_to :guest_user, class_name: "User"

	validates :host_user_id, presence: true
	validates :guest_user_id, presence: true
end
