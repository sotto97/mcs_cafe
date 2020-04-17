class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :skills, dependent: :destroy
  has_many :notices, dependent: :destroy
  # ユーザーのprofile_imageの実装
  attachment :profile_image, destroy: false

  # menuのimageの記述

  # フォロー機能
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship",  dependent: :destroy
  # 自分をフォローしている人
  has_many :following, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  # 自分がフォローしている人
  has_many :followers, through: :follower_relationships

  #フォローしているかを確認するメソッド
  def following?(user)
    following_relationships.find_by(following_id: user.id)
  end
  #フォローするときのメソッド
  def follow(user)
    following_relationships.create!(following_id: user.id)
  end
  #フォローを外すときのメソッド
  def unfollow(user)
    following_relationships.find_by(following_id: user.id).destroy
  end

  def active_for_authentication?
    super && (self.is_deleted == false)
  end
end
