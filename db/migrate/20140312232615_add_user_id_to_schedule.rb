class AddUserIdToSchedule < ActiveRecord::Migration
  def change
  	add_column :schedules , :user_id , :integer
  end
end
