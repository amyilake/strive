# == Schema Information
#
# Table name: schedules
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  goal_id     :integer
#  starttime   :datetime
#  endtime     :datetime
#  all_day     :boolean          default(FALSE)
#  status      :integer
#  created_at  :datetime
#  updated_at  :datetime
#  color       :string(255)
#  user_id     :integer
#  done        :boolean          default(FALSE)
#  hours       :float
#

require 'spec_helper'

describe Schedule do
  before do
    @schedule = Schedule.new(title: "my schedule", description: "mydescription",
                     goal_id: 1, user_id:1 , starttime: "2014-03-09 17:07:51",
                     endtime: "2014-03-09 17:07:51" ,all_day: false, status: 1)
  end
   
  subject { @schedule }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:goal_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:starttime) }
  it { should respond_to(:endtime) }
  it { should respond_to(:all_day) }
  it { should respond_to(:status) }

  it { should be_valid }
  
  describe "when no (title ,user_id ,starttime , endtime )" do
  	before { @schedule.title = "" , @schedule.user_id = nil , 
  		       @schedule.starttime = "" , @schedule.endtime = ""}
 		it { should_not be_valid }
  end

end
