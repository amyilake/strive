# == Schema Information
#
# Table name: schedules
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  goal_id     :integer
#  starttime   :datetime
#  endtime     :datetime
#  all_day     :boolean          default(FALSE)
#  status      :integer
#  created_at  :datetime
#  updated_at  :datetime
#  color       :string(255)
#  user_id     :integer
#  done        :boolean          default(FALSE)
#  hours       :float
#

class Schedule < ActiveRecord::Base

	belongs_to :goal
	belongs_to :user

	validates  :user_id , :starttime , :endtime , presence: true

	def self.total_grouped_by_day(start)
		schedules = where(starttime: start.beginning_of_day..Time.zone.now)
		schedules = schedules.group("date(starttime)")
		schedules = schedules.select("starttime, sum(hours) as total_hours")
		#schedules = schedules.select.sum(:hours)
		schedules.group_by { |o| o.starttime.to_date }
		#binding.pry
	end

end
