class Page < ApplicationRecord
  belongs_to :user
  # バリデーション
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 60 }
  validates :content, presence: true, length: { maximum: 800 }
  validate  :picture_size
end
