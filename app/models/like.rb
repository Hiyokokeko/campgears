class Like < ApplicationRecord
  belongs_to :user
  belongs_to :page
  counter_culture :page
  validates :user_id, presence: true
  validates :page_id, presence: true
  validates :user_id, uniqueness: { scope: :page_id }
end
