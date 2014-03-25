# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)      default(""), not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

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
