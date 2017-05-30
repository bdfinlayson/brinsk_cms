class AddContactIdToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :contact_id, :integer
    add_index :tasks, :contact_id
  end
end
