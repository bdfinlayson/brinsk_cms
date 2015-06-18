class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.datetime :due
      t.boolean :completed
      t.references :taskable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
