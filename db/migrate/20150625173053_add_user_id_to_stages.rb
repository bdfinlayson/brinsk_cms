class AddUserIdToStages < ActiveRecord::Migration
  def change
    add_column :stages, :user_id, :integer
  end
end
