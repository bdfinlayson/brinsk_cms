class AddStartedAtToTask < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :started_at, :datetime
  end
end
