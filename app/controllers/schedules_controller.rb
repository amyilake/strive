class SchedulesController < ApplicationController

	before_action :login_required 
	helper SchedulesHelper

	def index
		if params[:goal_id] != nil 
			@goal = Goal.find(params[:goal_id])
			render "index_for_calendar"
		end
		@chart = SchedulePresenter.new(:user => current_user).chart
		@chart_donut = SchedulePresenter.new(:user => current_user).chart_donut
		@schedules = current_user.schedules.order(:starttime)
	end

	def index_for_account
	end

	def new

		@goal = Goal.find(params[:goal_id])
		@schedule = current_user.schedules.build(:goal_id => params[:goal_id] ,
																			:starttime => params[:starttime] ,
		                                  :endtime => params[:endtime] ,
		                                  :all_day => params[:all_day],
		                                  :hours => '0.5' ,
		                                  :status => '1' )
	  #binding.pry
		render :json => { :form => render_to_string(:partial => 'edit_form') }
	end

	def new_for_account
		@schedule = current_user.schedules.build(
																			:starttime => params[:starttime] ,
		                                  :endtime => params[:endtime] ,
		                                  :all_day => params[:all_day],
		                                  :hours => '0.5' ,
		                                  :status => '1' )
	  #binding.pry
		render :json => { :form => render_to_string(:partial => 'edit_form') }
	end

	def create
		@schedule = current_user.schedules.new(schedule_params)
		#binding.pry

		if @schedule.save
		   render :nothing => true  
	    else
	     render :text => event.errors.full_messages.to_sentence, :status => 422
		end 
	end

	def edit
		
		@schedule = current_user.schedules.find(params[:id])
    render :json => { :form => render_to_string(:partial => 'edit_form') }	
	end

	def update
		@schedule = Schedule.find_by_id(params[:id])
    @schedule.update(schedule_params)
    #binding.pry
		if @schedule.save
			#redirect_to goal_schedules_path(@goal.id)
		  render :nothing => true
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
			# if have goal_id , find goal's schedules , else find user's schedules
			
			if params[:goal_id] != nil 
				@goal = Goal.find(params[:goal_id])
	   	  @schedules = @goal.schedules.find(:all, :conditions => ["starttime >= '#{Time.at(params['start'].to_i).to_formatted_s(:db)}' and endtime <= '#{Time.at(params['end'].to_i).to_formatted_s(:db)}'"] )
			else
				@user = current_user
	    	@schedules = @user.schedules.find(:all, :conditions => ["starttime >= '#{Time.at(params['start'].to_i).to_formatted_s(:db)}' and endtime <= '#{Time.at(params['end'].to_i).to_formatted_s(:db)}'"] )
			end

	    schedules = [] 
	    
	    @schedules.each do |schedule|
	    	#if schedule in goal and schedule not has own color ,use goal color
	    	if schedule.goal != nil && schedule.color == nil
	    		schedule_color = schedule.goal.color
	    	else
	    		schedule_color = schedule.color
	    	end
	      schedules << {:description => schedule.description ,:color => schedule_color ,
	      	            :title => schedule.title , :allDay => schedule.all_day ,
	      	            :id => schedule.id, :start => "#{schedule.starttime.iso8601}",
	      	            :end => "#{schedule.endtime.iso8601}" }
	    end
	    #binding.pry
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
	      @schedule.hours += (params[:minute_delta].to_f)/60
	      @schedule.save

	    end    
	    render :nothing => true
	end

	private
		def schedule_params
			#params[:user_id] = current_user.id

			params.require(:schedule).permit(:hours,:goal_id,:user_id,:title,:description,:starttime,
				                               :endtime,:status,:all_day,:color,:done)
		end

end
