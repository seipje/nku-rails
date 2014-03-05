class Student < ActiveRecord::Base 

  
  has_secure_password
  has_many :attendances, dependent: :destroy
  
  validates :name, 
    :presence => true, 
    :length => { :minimum => 3 }, 
    :uniqueness => true

  validates :password_digest,
    :length => { :minimum => 4, :if => :validate_password? },
    :confirmation => { :if => :validate_password? }
  
  validates :email, presence: true

  ActiveRecord::Base.clear_active_connections!
   
  def avatar
    Avatar.from_student(self)
  end
  
  def self.present
    all - absent
  end
  
  def self.in_seat(seat, date=Date.today)
    attendances =  Attendance.where("attended_on = ? AND seat = ?", date, seat)
    student_ids = attendances.collect{ |a| a.student_id }
    return Student.find(student_ids)
  end
  
  def self.absent(date=Date.today)
    attendances = Attendance.where("attended_on = ?", date)
    attending_students = attendances.collect{ |a| a.student_id }
    return Student.where.not(id: attending_students)
  end
  
  private

  def validate_password?
    password.present? || password_confirmation.present?
  end
  
end
