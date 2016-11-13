class CreateTaggings < ActiveRecord::Migration[5.0]
  def change
    create_table :taggings do |t|
      t.string :taggable_type
      t.integer :taggable_id
      t.integer :tag_id

      t.timestamps
    end
    add_index :taggings, :tag_id
    add_index :taggings, :taggable_id
  end
end
