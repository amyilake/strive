require 'spec_helper'

describe SchedulePresenter do
  let(:user) { create(:user) }
  let(:goal) { create(:goal , :owner => user)}
  let(:schedule) {create(:schedule ,:goal => goal, :hours => 1 ,:starttime =>7.days.ago.to_date )}
  let(:schedule_today_before_now) {create(:schedule ,:goal => goal, :hours => 1 ,:starttime =>DateTime.now-1.minutes )}
  let(:schedule_today_after_now) {create(:schedule ,:goal => goal, :hours => 1 ,:starttime =>DateTime.now+1.minutes )}
  let(:schedule_next_week) {create(:schedule ,:goal => goal, :hours => 1 ,:starttime =>(DateTime.now+5.days) )}
  let(:schedule_past){create(:schedule ,:goal => goal, :hours => 1 ,:starttime =>(DateTime.now-5.days) )}
  let(:schedule_future){create(:schedule ,:goal => goal, :hours => 1 ,:starttime =>(DateTime.now+10.days) )}
  


  context '#chart' do
    it 'normal when only 1 goal ,1 schedules should return expected hash' do
      expected_hash = [ 
      	{ :starttime => 7.days.ago.to_date , goal.title => schedule.hours},
      	{ :starttime => 6.days.ago.to_date , goal.title => 0.0},
      	{ :starttime => 5.days.ago.to_date , goal.title => 0.0},
      	{ :starttime => 4.days.ago.to_date , goal.title => 0.0},
      	{ :starttime => 3.days.ago.to_date , goal.title => 0.0},
      	{ :starttime => 2.days.ago.to_date , goal.title => 0.0},
      	{ :starttime => 1.days.ago.to_date , goal.title => 0.0},
        { :starttime => 0.days.ago.to_date , goal.title => 0.0}     	
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
    let(:schedule2) {create(:schedule ,:goal => goal2, :hours => 1 ,:starttime =>6.days.ago.to_date )}
    let(:schedule3) {create(:schedule ,:goal => goal2, :hours => 1 ,:starttime =>6.days.ago.to_date )}

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
  end

  context '#data' do
    
    it "today data" do
      expected = [schedule_today_before_now,schedule_today_after_now]       
      result = SchedulePresenter.new(:user => user).today_data 
      result.should == expected
    end

    it "next week data" do
      expected = [schedule_next_week]       
      result = SchedulePresenter.new(:user => user).next_week_data 
      result.should == expected
    end

    it "past data" do
      expected = [schedule_today_before_now,schedule_today_before_now]       
      result = SchedulePresenter.new(:user => user).past_data 
      result.should == expected
    end

    it "future data" do
      expected = [schedule_future]       
      result = SchedulePresenter.new(:user => user).future_data 
      result.should == expected
    end
  end
end
