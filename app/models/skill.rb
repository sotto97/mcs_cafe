class Skill < ApplicationRecord
	belongs_to :user

	validates :user_id, presence: true
	validates :skill_name, presence: true
end
