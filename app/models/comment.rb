class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :page
  validates :content, presence: true, length: { maximum: 140 }
end
