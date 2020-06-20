class User < ApplicationRecord
 # メール
 attr_accessor :remember_token, :reset_token
 before_save   :downcase_email
 validates :name, presence: true, length: { maximum: 50 }
 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
 validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
 # パスワード
 has_secure_password
 validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
