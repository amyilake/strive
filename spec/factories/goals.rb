# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :goal do
  	sequence(:title)  { |n| "title #{n}" }
    sequence(:description) { |n| "description #{n}"}
    user_id 1
  end

   
end
