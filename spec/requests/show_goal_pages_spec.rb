require 'spec_helper'

describe "ShowGoalPages" do
	subject {page}
	let(:user) { FactoryGirl.create(:user) }
	before{
		FactoryGirl.create(:goal)
		FactoryGirl.create(:schedule)
		sign_in	user
  	visit goal_path(user.goals.first.id) 
	}
	it { should have_content('刪除目標')}
	
	it { should have_content(user.goals.first.schedules.first.title)}


 
end
