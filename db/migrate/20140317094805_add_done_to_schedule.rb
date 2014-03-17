class AddDoneToSchedule < ActiveRecord::Migration
  def change
  	add_column :schedules , :done ,:boolean ,:default => false
  end
end
