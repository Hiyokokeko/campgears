class Page < ApplicationRecord
  belongs_to :user
  # バリデーション
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 60 }
  validates :content, presence: true, length: { maximum: 800 }
  validate  :picture_size

  # 画像投稿
  mount_uploader :picture, PictureUploader

  private

  # アップロードされた画像のサイズをバリデーションする
  def picture_size
    errors.add(:picture, '5MB以下である必要があります') if picture.size > 5.megabytes
  end
end
