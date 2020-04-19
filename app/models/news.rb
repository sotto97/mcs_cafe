class News < ApplicationRecord
	belongs_to :admin

	validates :title, presence: true
	validates :body, presence: true

  # 一度に表示するnewsの数
  paginates_per 5
end