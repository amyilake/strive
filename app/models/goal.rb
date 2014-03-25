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

class Goal < ActiveRecord::Base

	has_many :schedules , dependent: :destroy
	belongs_to :owner , :class_name =>"User" , :foreign_key => :user_id

	def editable_by?(user)
		user && user == owner
	end

end
