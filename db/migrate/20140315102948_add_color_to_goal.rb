class AddColorToGoal < ActiveRecord::Migration
  def change
  	add_column :goals, :color, :string
  end
end
