# == Schema Information
#
# Table name: goals
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  color       :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :goal do
  	sequence(:title)  { |n| "title #{n}" }
    sequence(:description) { |n| "description #{n}"}
  end

   
end
