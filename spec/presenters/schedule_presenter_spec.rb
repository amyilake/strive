require 'spec_helper'

describe SchedulePresenter do
  let(:user) { create(:user) }
  let(:goal) { create(:goal , :owner => user)}
  let!(:schedule) {create(:schedule,:user => user ,:goal => goal, :hours => 1 ,:starttime =>7.days.ago.to_date )}
  
  context '#chart' do
    context '#by user' do
      it 'normal when only 1 goal ,1 schedules should return expected hash' do
        expected_hash = [ 
        	{ :starttime => 7.days.ago.to_date , goal.title => schedule.hours  },
        	{ :starttime => 6.days.ago.to_date , goal.title => 0.0  },
        	{ :starttime => 5.days.ago.to_date , goal.title => 0.0 },
        	{ :starttime => 4.days.ago.to_date , goal.title => 0.0 },
        	{ :starttime => 3.days.ago.to_date , goal.title => 0.0 },
        	{ :starttime => 2.days.ago.to_date , goal.title => 0.0 },
        	{ :starttime => 1.days.ago.to_date , goal.title => 0.0 },
          { :starttime => 0.days.ago.to_date , goal.title => 0.0 }     	
        ]
        result = SchedulePresenter.new(:user => user).chart 
        result.should == expected_hash
      end

      it 'donut_chart when only 1 goal ,1 schedule should return expected hash' do
        expected_hash = [ 
          {label: goal.title, value: schedule.hours}    
        ]
        result = SchedulePresenter.new(:user => user).chart_donut 
        result.should == expected_hash
      end

      let(:goal2) { create(:goal , :owner =>user )}
      let(:schedule2) {create(:schedule ,:user => user,:goal => goal2, :hours => 1 ,:starttime =>6.days.ago.to_date )}
      let(:schedule3) {create(:schedule ,:user => user,:goal => goal2, :hours => 1 ,:starttime =>6.days.ago.to_date )}

      it 'normal_chart when have 2 goals , 3 schedules should return expected hash' do
        expected_hash = [ 
          { :starttime => 7.days.ago.to_date , goal.title => schedule.hours , goal2.title => 0},
          { :starttime => 6.days.ago.to_date , goal.title => 0 , goal2.title => schedule2.hours+schedule3.hours},
          { :starttime => 5.days.ago.to_date , goal.title => 0 , goal2.title => 0},
          { :starttime => 4.days.ago.to_date , goal.title => 0 , goal2.title => 0},
          { :starttime => 3.days.ago.to_date , goal.title => 0 , goal2.title => 0},
          { :starttime => 2.days.ago.to_date , goal.title => 0 , goal2.title => 0},
          { :starttime => 1.days.ago.to_date , goal.title => 0 , goal2.title => 0},
          { :starttime => 0.days.ago.to_date , goal.title => 0 , goal2.title => 0}      
        ]
        result = SchedulePresenter.new(:user => user).chart 
        result.should == expected_hash
      end

      it 'donut_chart when 2 goal ,2 schedule should return expected hash' do
        expected_hash = [ 
          {label: goal.title, value: schedule.hours},
          {label: goal2.title , value: schedule2.hours+schedule3.hours}    
        ]
        result = SchedulePresenter.new(:user => user).chart_donut 
        result.should == expected_hash
      end

      it 'labels value' do
        expected_hash = [ 
          goal.title,goal2.title 
        ]
        result = SchedulePresenter.new(:user => user ).labels 
        result.should == expected_hash
      end 

      it 'donut_goal_index : find goal index of the user' do
        expected = -1
        result = SchedulePresenter.new(:user => user  ).donut_goal_index 
        result.should == expected
      end   

    end
    context '#by goal' do

      let!(:goal2) { create(:goal , :owner =>user )}
      let(:schedule2) {create(:schedule ,:user => user,:goal => goal2, :hours => 1 ,:starttime =>6.days.ago.to_date )}
      let(:schedule3) {create(:schedule ,:user => user,:goal => goal2, :hours => 1 ,:starttime =>6.days.ago.to_date )}

      it 'normal_chart when have goal2 , 2 schedules should return expected hash' do
        expected_hash = [ 
          { :starttime => 7.days.ago.to_date , goal2.title => 0},
          { :starttime => 6.days.ago.to_date , goal2.title => schedule2.hours+schedule3.hours},
          { :starttime => 5.days.ago.to_date , goal2.title => 0},
          { :starttime => 4.days.ago.to_date , goal2.title => 0},
          { :starttime => 3.days.ago.to_date , goal2.title => 0},
          { :starttime => 2.days.ago.to_date , goal2.title => 0},
          { :starttime => 1.days.ago.to_date , goal2.title => 0},
          { :starttime => 0.days.ago.to_date , goal2.title => 0}      
        ]
        result = SchedulePresenter.new(:user => user , :goal => goal2 ).chart 
        result.should == expected_hash
      end

      it 'labels value' do
        expected_hash = [ 
          goal2.title 
        ]
        result = SchedulePresenter.new(:user => user , :goal => goal2 ).labels 
        result.should == expected_hash
      end

      it 'donut_goal_index : find goal index of the user' do
        expected = 1
        result = SchedulePresenter.new(:user => user ,:goal => goal2 ).donut_goal_index 
        result.should == expected
      end      
    end
  end

  
  context '#data' do
  
    let!(:schedule_today_before_now) {create(:schedule ,:user => user,:goal => goal, :hours => 1 ,:starttime =>DateTime.now-1.minutes )}
    let!(:schedule_today_after_now) {create(:schedule ,:user => user,:goal => goal, :hours => 1 ,:starttime =>DateTime.now+1.minutes )}
    let!(:schedule_next_week) {create(:schedule ,:user => user,:goal => goal, :hours => 1 ,:starttime =>(DateTime.now+5.days) )}
    let!(:schedule_past){create(:schedule ,:user => user,:goal => goal, :hours => 1 ,:starttime =>(DateTime.now-5.days) )}
    let!(:schedule_future){create(:schedule ,:user => user,:goal => goal, :hours => 1 ,:starttime =>(DateTime.now+10.days) )}

    let(:goal3) { create(:goal , :owner => user )}
    let!(:schedule_today_before_now2) {create(:schedule ,:user => user,:goal => goal3, :hours => 1 ,:starttime =>DateTime.now-1.minutes )}
    let!(:schedule_today_after_now2) {create(:schedule ,:user => user,:goal => goal3, :hours => 1 ,:starttime =>DateTime.now+1.minutes )}
    let!(:schedule_next_week2) {create(:schedule ,:user => user,:goal => goal3, :hours => 1 ,:starttime =>(DateTime.now+5.days) )}
    let!(:schedule_past2){create(:schedule ,:user => user,:goal => goal3, :hours => 1 ,:starttime =>(DateTime.now-5.days) )}
    let!(:schedule_future2){create(:schedule ,:user => user,:goal => goal3, :hours => 1 ,:starttime =>(DateTime.now+10.days) )}


    it "today data" do
      expected = [schedule_today_before_now,schedule_today_before_now2,schedule_today_after_now,schedule_today_after_now2]       
      result = SchedulePresenter.new(:user => user).today_data 
      result.should == expected
    end

    it "next week data" do
      expected = [schedule_next_week,schedule_next_week2]       
      result = SchedulePresenter.new(:user => user).next_week_data 
      result.should == expected
    end

    it "past data" do
      expected = [schedule,schedule_past,schedule_past2,schedule_today_before_now,schedule_today_before_now2]
      result = SchedulePresenter.new(:user => user).past_data 
      result.should == expected
    end

    it "future data" do
      expected = [schedule_today_after_now,schedule_today_after_now2,schedule_next_week,schedule_next_week2,schedule_future,schedule_future2]       
      result = SchedulePresenter.new(:user => user).future_data 
      result.should == expected
    end
  end

end
