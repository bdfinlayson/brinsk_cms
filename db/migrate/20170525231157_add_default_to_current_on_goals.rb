class AddDefaultToCurrentOnGoals < ActiveRecord::Migration[5.0]
  def change
    change_column :goals, :current, :boolean, default: true
  end
end
