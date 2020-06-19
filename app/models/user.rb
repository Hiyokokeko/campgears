class User < ApplicationRecord
  # パスワードセキュリティ
  has_secure_password
end
