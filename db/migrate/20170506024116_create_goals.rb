class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.text :objective
      t.integer :contact_id
      t.boolean :current

      t.timestamps
    end
    add_index :goals, :objective
    add_index :goals, :contact_id
  end
end
