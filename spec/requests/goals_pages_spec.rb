require 'spec_helper'

describe "GoalsPages" do
	subject {page}
  describe "Goal pages" do
  	before do
  		FactoryGirl.create(:goal)
  		visit goals_path 
  	end
  
    it { should have_content('Goal index') }
  	
    it "should list all goals" do
      Goal.all.each do |goal|
        expect(page).to have_content(goal.title)
        expect(page).to_not have_content("進入")
      end
    end

		describe "when user not login" do
      it { should_not have_content('新增目標')}
     	it { should_not have_content('月曆表')}
    end

  	describe "when user have logind" do
			let(:user) { FactoryGirl.create(:user) }
			before  do 
				sign_in	user 
	    end
	    it { should have_content('新增目標')}
     	it { should have_content('月曆表')}

     	it "user can enter his own goal" do
	     	user.goals.each do |goal|
	        expect(page).to have_content("進入")
	      end
     	end
    end

  end
end
