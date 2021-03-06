class GoalsController < ApplicationController
	include SchedulesHelper
	before_action :login_required , :only => [ :show,:new , :create , :edit , :update , :destroy]

	def index
		#@goals = Goal.all
		@goals = Goal.paginate(:page => params[:page], :per_page => 9)
	end

	def show
		@goal = Goal.find(params[:id])
		@schedules = @goal.schedules.order(:starttime)
		get_schedules_data_chart(@goal)
		
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
