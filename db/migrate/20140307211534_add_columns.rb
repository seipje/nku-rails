class AddColumns < ActiveRecord::Migration
  def change
    add_column :assignments, :score, :integer
    add_column :assignments, :total, :integer
  end
end
