class GoalsController < ApplicationController

	def index
		@goals = Goal.all
	end

	def show
		
	end

	def new
		@goal = Goal.new
	end

	def create
		@goal = current_user.goals.build(link_params)
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

	private 
		
		def link_params
			params.require(:goal).permit(:title,:description,:user_id)
		end
end
