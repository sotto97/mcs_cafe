class Menu < ApplicationRecord
  attachment :menu_image, destroy: false

  validates :menu_image, presence: true
end
