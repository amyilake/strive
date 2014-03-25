class SchedulePresenter
  attr_reader :user

  def initialize(user: user)
    @user = user
  end

  def chart    
    h_all={}   
    (1.weeks.ago.to_date..Date.today).map do |date|
      h_starttime={
        :starttime => date
      }
      h_all=get_user_goals_schedules_hours_sum(h_starttime,date)
    end
  
  end

  def chart_donut
    user.goals.map do |goal| 
      {
        :label => goal.title , :value => goal.schedules.sum(:hours)
      }
    end
  end

  
  private
   def get_user_goals_schedules_hours_sum(h_starttime,date)
      user.goals.each do |goal|
        h_goal_schedule_hours={
          goal.title => goal.schedules.where("date(starttime) = ?", date).sum(:hours),
        }
        h_starttime=h_starttime.merge(h_goal_schedule_hours) 
      end
      h_starttime
   end

end
