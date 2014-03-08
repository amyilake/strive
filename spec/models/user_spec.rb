require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "1qaz2wsx", password_confirmation: "1qaz2wsx")
  end

  subject { @user }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  describe "when name is not present" do
  	before { @user.name = "" }
  	it { should_not be_valid}
  end

  describe  "when name is already taken"  do 
    before  do 
      user_with_same_name  =  @user.dup 
      user_with_same_name.email = "user2@example.com"
      user_with_same_name.save 
    end
     it  {  should_not  be_valid  } 
  end 
end
