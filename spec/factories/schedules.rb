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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule do
    title "MyString"
    description "MyText"
    goal_id 1
    user_id 1
    starttime "2014-03-09 17:07:51"
    endtime "2014-03-09 17:07:51"
    all_day false
    status 1
  end

end
