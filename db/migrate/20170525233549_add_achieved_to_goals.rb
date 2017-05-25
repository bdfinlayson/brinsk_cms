class AddAchievedToGoals < ActiveRecord::Migration[5.0]
  def change
    add_column :goals, :achieved, :boolean, default: false
  end
end
