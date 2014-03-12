class SchedulesController < ApplicationController

	def index
		@goal = Goal.find(params[:goal_id])
	end

	def new
		@goal = Goal.find(params[:goal_id])
		@schedule = @goal.schedules.build(:starttime => params[:starttime] ,
		                                  :endtime => params[:endtime] ,
		                                  :all_day => params[:all_day],
		                                  :status => 1 )
	  #binding.pry
		render :json => { :form => render_to_string(:partial => 'edit_form') }
	end

	def create
		@goal = Goal.find(params[:goal_id])
		@schedule = @goal.schedules.new(schedule_params)
		#binding.pry

		if @schedule.save
		   render :nothing => true  
	    else
	     render :text => event.errors.full_messages.to_sentence, :status => 422
		end 
	end

	def edit
		@goal = Goal.find(params[:goal_id])
		@schedule = @goal.schedules.find(params[:id])
    render :json => { :form => render_to_string(:partial => 'edit_form') }	
	end

	def update
		@goal = Goal.find(params[:goal_id])
		@schedule = Schedule.find_by_id(params[:id])
    @schedule.update(schedule_params)
    #binding.pry
		if @schedule.save
			redirect_to goal_schedules_path(@goal.id)
		  #render :nothing => true
	    else
	     render :text => event.errors.full_messages.to_sentence, :status => 422
		end 
	end

	

	def destroy
		@schedule = Schedule.find_by_id(params[:id])
		@schedule.destroy

		render :nothing => true   
	end

	def get_events
			@goal = Goal.find(params[:goal_id])
	    @schedules = @goal.schedules.find(:all, :conditions => ["starttime >= '#{Time.at(params['start'].to_i).to_formatted_s(:db)}' and endtime <= '#{Time.at(params['end'].to_i).to_formatted_s(:db)}'"] )
	    schedules = [] 

	    @schedules.each do |schedule|
	      schedules << {:description => schedule.description ,:color =>schedule.color ,
	      	            :title => schedule.title , :allDay => schedule.all_day ,
	      	            :id => schedule.id, :start => "#{schedule.starttime.iso8601}",
	      	            :end => "#{schedule.endtime.iso8601}" }
	    end
	    render :text => schedules.to_json
	end

  def move
  	@schedule = Schedule.find_by_id(params[:id])
	    if @schedule
	      @schedule.starttime = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@schedule.starttime))
	      @schedule.endtime = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@schedule.endtime))
	      @schedule.save
	    end
	  render :nothing => true
  end

	def resize
	    @schedule = Schedule.find_by_id params[:id]
	    if @schedule
	      @schedule.endtime = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@schedule.endtime))
	      @schedule.save
	    end    
	    render :nothing => true
	end

	private
		def schedule_params
			params.require(:schedule).permit(:title,:description,:starttime,
				                               :endtime,:status,:all_day,:color)
		end

end
