class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments
  has_many :favorites
  attachment :image, destroy: false

  # カラムにimage_idがあるが、画像投稿は任意ではないのでバリデーションしない
	validates :user_id, presence: true
	validates :body, presence: true


  def favorited_by?(user)
  	favorites.where(user_id: user.id).exists?
  end

  # post allで一度に表示するpostの数
  paginates_per 5
end
