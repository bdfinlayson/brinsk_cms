class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.integer :project_id
      t.string :name

      t.timestamps null: false
    end
  end
end
