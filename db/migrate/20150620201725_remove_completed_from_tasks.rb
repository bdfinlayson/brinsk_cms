class RemoveCompletedFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :completed, :boolean
  end
end
