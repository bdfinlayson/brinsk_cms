class CreateRetrospectives < ActiveRecord::Migration[5.0]
  def change
    create_table :retrospectives do |t|
      t.text :what_has_gone_well
      t.text :what_has_gone_poorly
      t.text :how_are_your_goals
      t.integer :user_id
      t.integer :contact_id

      t.timestamps
    end
    add_index :retrospectives, :user_id
    add_index :retrospectives, :contact_id
  end
end
