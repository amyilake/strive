class GoalsController < ApplicationController

	before_action :login_required , :only => [ :show,:new , :create , :edit , :update , :destroy]

	def index
		@goals = Goal.all
	end

	def show
		@goal = Goal.find(params[:id])
		@schedules = @goal.schedules
		
		@schedulePresenter = SchedulePresenter.new(:user => current_user ,:goal => @goal)
		@chart = @schedulePresenter.chart
		@today_schedules = @schedulePresenter.today_data
		@next_week_schedules = @schedulePresenter.next_week_data
		@past_schedules = @schedulePresenter.past_data
		@future_schedules = @schedulePresenter.future_data
		#binding.pry
		#gon.products = @chart
	end

	def new
		@goal = Goal.new
	end

	def create
		@goal = current_user.goals.build(goal_params)
		@goal.save

		redirect_to goals_path
	end

	def edit
		@goal = current_user.goals.find(params[:id])
	end

	def update
		@goal = current_user.goals.find(params[:id])
		@goal.update(goal_params)
		if @goal.save
			redirect_to goal_path(@goal)
		else
			render :edit
		end
	end

	def destroy
		@goal = current_user.goals.find(params[:id])
		
		@goal.destroy
		redirect_to goals_path

	end

	private 
		
		def goal_params
			params.require(:goal).permit(:title,:description,:user_id,:color)
		end
end
