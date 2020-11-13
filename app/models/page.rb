class Page < ApplicationRecord
  belongs_to :user
  # バリデーション
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 60 }
  validates :content, presence: true, length: { maximum: 800 }
  validate  :picture_size
  # いいね機能
  has_many :likes, dependent: :destroy
  # どのuserからいいねがあるか
  has_many :liked_by, through: :likes, source: :user
  default_scope -> { order(created_at: :desc) }
  # 画像投稿
  mount_uploader :picture, PictureUploader
  # カテゴリー分け（中間テーブルに対する関連付け）
  has_many :page_category_relations, dependent: :destroy
  # 中間テーブルを介するcategoryテーブルへの関連付け
  has_many :categories, through: :page_category_relations
  # コメント投稿
  has_many :comments, dependent: :destroy

  # titleとcontentを部分一致で検索する
  # ここのself.はPage.の意味
  def self.search(search)
    if search
      where(['title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%"])
    else
      all
    end
  end

  # いいねランキング
  def self.create_all_ranks
    Page.unscoped.find(Like.group(:page_id).order(Arel.sql('count(page_id) desc')).limit(10).pluck(:page_id))
  end

  private

  # アップロードされた画像のサイズをバリデーションする
  def picture_size
    errors.add(:picture, '5MB以下である必要があります') if picture.size > 5.megabytes
  end
end
