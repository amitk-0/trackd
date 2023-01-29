class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :summary
      t.string :description
      t.references :project, null: false, foreign_key: true
      t.integer :status, default: 0, null: false

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
