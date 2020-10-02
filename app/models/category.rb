class Category < ApplicationRecord
  validates :name, presence: true
  # カテゴリー分け（中間テーブルに対する関連付け）
  has_many :page_category_relations, dependent: :destroy
  # 中間テーブルを介するpageテーブルへの関連付け
  has_many :pages, through: :page_category_relations
end
