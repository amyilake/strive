class Goal < ActiveRecord::Base

	belongs_to :user
	has_many :schedules , dependent: :destroy

end
