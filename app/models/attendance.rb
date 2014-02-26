class Attendance < ActiveRecord::Base
  
  belongs_to :student
  
  validates :student_id, uniqueness: { scope: :attended_on, 
    message: ": You've already recorded your attendance." }
  
  validates :seat, numericality: { only_integer: true,
    greater_than_or_equal_to: 1, less_than_or_equal_to: 4,
    message: ": You must enter a value between 1 and 4."}
end