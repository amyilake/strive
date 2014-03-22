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
