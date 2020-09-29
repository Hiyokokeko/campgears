class CreatePageCategoryRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :page_category_relations do |t|
      t.references :page, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
