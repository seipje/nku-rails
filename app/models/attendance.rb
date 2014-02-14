class Attendance < ActiveRecord::Base
  validates :student_id, uniqueness: { scope: :attended_on, 
    message: "You've already recorded your attendance." }
end