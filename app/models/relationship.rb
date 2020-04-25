class Relationship < ApplicationRecord
	#自分をフォローしているユーザー followerクラスではなく、Userクラス
	belongs_to :follower, class_name: "User"
	#自分がフォローしているユーザー followingクラスではなく、Userクラス
	belongs_to :following, class_name: "User"

	validates :follower_id, presence: true
	validates :following_id, presence: true
end
