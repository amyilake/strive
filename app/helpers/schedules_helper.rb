module SchedulesHelper
	
	def schedules_chart_data user	
		(2.weeks.ago.to_date..Date.today).map do |date|
			h1={
				:starttime => date
		  }
			user.goals.each do |goal|
				h2={
					goal.title => goal.schedules.where("date(starttime) == ?", date).sum(:hours),
				}
				h1=h1.merge(h2)	
			end
			h1=h1	
		end
	end

	def schedules_chart_donut_data user	
	
		user.goals.each do |goal|
		{
			:label => goal.title,
			:value => goal.schedules.sum(:hours),
		}
		end
	end
end