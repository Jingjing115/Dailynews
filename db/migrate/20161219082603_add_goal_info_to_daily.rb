class AddGoalInfoToDaily < ActiveRecord::Migration
  def change
    add_column :dailies, :goal_info, :string
  end
end
