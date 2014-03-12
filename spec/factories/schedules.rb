# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule do
    title "MyString"
    description "MyText"
    goal_id 1
    starttime "2014-03-09 17:07:51"
    endtime "2014-03-09 17:07:51"
    all_day false
    status 1
  end
end
