class AddFieldsToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :student_name, :string
    add_column :assignments, :assignment_name, :string
  end
end
