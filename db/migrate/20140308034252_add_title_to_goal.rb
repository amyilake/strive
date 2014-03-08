class AddTitleToGoal < ActiveRecord::Migration
  def change
  	rename_column :goals, :name, :title
  end
end
