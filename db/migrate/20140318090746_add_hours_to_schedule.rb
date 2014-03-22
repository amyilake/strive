class AddHoursToSchedule < ActiveRecord::Migration
  def change
  	add_column :schedules , :hours , :float
  end
end
