module SchedulesHelper

	def get_schedules_data_chart(goal)
		
		if goal != nil
			@schedulePresenter = SchedulePresenter.new(:user => current_user , :goal => goal )
		else
			@schedulePresenter = SchedulePresenter.new(:user => current_user )

		end
		
		@chart = @schedulePresenter.chart
		@chart_donut = @schedulePresenter.chart_donut
		@today_schedules = @schedulePresenter.today_data
		@next_week_schedules = @schedulePresenter.next_week_data
		@past_schedules = @schedulePresenter.past_data
		@future_schedules = @schedulePresenter.future_data
		@labels=@schedulePresenter.labels
		@donut_goal_index=@schedulePresenter.donut_goal_index
	end

end
