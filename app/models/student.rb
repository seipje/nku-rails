class Student < ActiveRecord::Base
  
  has_secure_password

  
  validates :name, 
    :presence => true, 
    :length => { :minimum => 3 }, 
    :uniqueness => true

  validates :password_digest,
    :length => { :minimum => 4, :if => :validate_password? },
    :confirmation => { :if => :validate_password? }
  
  validates :email, presence: true

  ActiveRecord::Base.clear_active_connections!
  
  has_many :attendances, dependent: :destroy
  
  def self.in_seat(seat, date)
  end
  
  def self.absent(date)
  end
  
  private

  def validate_password?
    password.present? || password_confirmation.present?
  end
  
end
