
class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :title
      t.text :description
      t.integer :goal_id
      t.datetime :starttime
      t.datetime :endtime
      t.boolean :all_day ,default: false
      t.integer :status

      t.timestamps
    end
  end
end
