class GoalsController < ApplicationController

	def index
		@goals = Goal.all
	end

	def show
		@goal = Goal.find(params[:id])
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
		
	end

	def destroy
		
	end

	def calendar	
		@goal = Goal.find(params[:goal_id])
	end

	private 
		
		def goal_params
			params.require(:goal).permit(:title,:description,:user_id)
		end
end
