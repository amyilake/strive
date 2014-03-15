class Schedule < ActiveRecord::Base

	belongs_to :goal
	belongs_to :user

	validates  :user_id , :starttime , :endtime , presence: true
end
