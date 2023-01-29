class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :code
      t.string :description
      t.references :project_lead, references: :users, null: true, foreign_key: { to_table: :users }

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
