class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :students, :imageURL, :image_url
  end
end
