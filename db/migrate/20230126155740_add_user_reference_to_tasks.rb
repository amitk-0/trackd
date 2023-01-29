class AddUserReferenceToTasks < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :assignee, index: true, null: true, unique: false, foreign_key: { to_table: :users }
    add_reference :tasks, :created_by, index: true, null: false, foreign_key: { to_table: :users }
  end
end
