class DropStages < ActiveRecord::Migration[5.0]
  def change
    drop_table :stages
  end
end
