class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :skills, dependent: :destroy
  has_many :notices, dependent: :destroy
  # ユーザーのprofile_imageの実装
  attachment :profile_image, destroy: false

  # バリデーションの設定
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true
  validates :username, presence: true
  validates :introduction, length: {maximum: 50}

  # チャット機能関連
  has_many :messages
  has_many :host_user_rooms, foreign_key: "guest_user_id", class_name: "Room",  dependent: :destroy
  has_many :host_users, through: :host_user_rooms
  has_many :guest_user_rooms, foreign_key: "host_user_id", class_name: "Room", dependent: :destroy
  has_many :guest_users, through: :guest_user_rooms

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
