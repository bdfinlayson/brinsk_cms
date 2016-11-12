class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :user_id
      t.string :color

      t.timestamps
    end
    add_index :tags, :user_id
  end
end
