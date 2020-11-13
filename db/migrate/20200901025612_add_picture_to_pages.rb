class AddPictureToPages < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :picture, :string
  end
end
