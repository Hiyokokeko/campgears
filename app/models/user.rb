class User < ApplicationRecord
  # アソシエーション
  # ページ投稿機能
  has_many :pages, dependent: :destroy
  # いいね機能
  has_many :likes, dependent: :destroy
  has_many :like_pages, through: :likes, source: :page
  # コメント投稿
  has_many :comments, dependent: :destroy
  # メール
  attr_accessor :remember_token, :reset_token
  before_save   :downcase_email
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  # パスワード
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # 渡された文字列のハッシュ値を返す
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update(remember_digest: User.digest(remember_token))
  end

  # トークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update(remember_digest: nil)
  end

  private

  # メールアドレスをすべて小文字にする
  def downcase_email
    email.downcase!
  end
end
