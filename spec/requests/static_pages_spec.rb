require 'spec_helper'

describe "StaticPages" do
	subject {page}
  describe "Home pages" do
  	before { visit '/static_pages/home'  }
      it { should have_content('Strive') }

      describe "when user not login" do
      	it { should have_content('登入')}
      	it { should have_content('註冊')}
      end

      describe "when user have login " do
      	before  do 
		        sign_in  FactoryGirl.create( :user ) 
		        FactoryGirl.create( :user ,  name:  "Bob" ,  email:  "bob@example.com" ) 
		        FactoryGirl.create( :user ,  name:  "Ben" ,  email:  "ben@example.com" ) 
		    end
		    it { should have_content('登出')}
      end
  end
end
