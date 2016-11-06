class AddPositionToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :position, :integer
    add_index :tasks, :position
  end
end
