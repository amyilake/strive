class SchedulePresenter
	attr_reader :user
  attr_reader :goal
  attr_reader :find_schedule

  def initialize(user: user , goal: goal)
    @user = user
    @goal = goal

    if goal != nil
      @find_schedule = goal
    else
      @find_schedule = user
    end

  end

  def today_task_num
    find_schedule.schedules.where("date(starttime) = ?", Date.today).count 
  end

  def today_data
    find_schedule.schedules.where("date(starttime) = ?", Date.today).order(:starttime)
  end

  def next_week_data
    find_schedule.schedules.where("date(starttime) > ? and date(starttime) <= ?",
     Date.today , Date.today+7.days).order(:starttime)
  end

  def past_data
    find_schedule.schedules.where("starttime < ? ",Time.now).order(:starttime)
    
  end

  def future_data
    find_schedule.schedules.where("starttime > ? ",Time.now).order(:starttime)
  end

  def chart    
    h_all={}   
    (1.weeks.ago.to_date..Date.today).map do |date|
      h_starttime={
        :starttime => date
      }
      h_all=get_user_goals_schedules_hours_sum(h_starttime,date)
    end
    #binding.pry
  end

  def chart_donut
    user.goals.map do |goal| 
      {
        :label => goal.title , :value => goal.schedules.sum(:hours)
      }
    end
  end

  
  # find goal index of the user
  def donut_goal_index
    if goal != nil
      goal_index = 0
      user.goals.each.with_index do |goal_find , index|        
        goal_index = index
        break if goal_find == goal  
      end
      goal_index
    else
      goal_index = -1
    end
    #binding.pry
  end

  def labels
    if goal != nil
      [goal.title]
    else
      user.goals.map do |goal| 
        goal.title
      end
    end
  end
  
  private
   def get_user_goals_schedules_hours_sum(h_starttime,date)
      if goal != nil
        h_goal_schedule_hours={
            goal.title => goal.schedules.where("date(starttime) = ?", date).sum(:hours),
          }
        h_starttime=h_starttime.merge(h_goal_schedule_hours)
      else 
        user.goals.each do |goal|
          h_goal_schedule_hours={
            goal.title => goal.schedules.where("date(starttime) = ?", date).sum(:hours),
          }
          h_starttime=h_starttime.merge(h_goal_schedule_hours) 
        end
      end
      h_starttime
   end

end