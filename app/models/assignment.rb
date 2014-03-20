class Assignment < ActiveRecord::Base 
  
   belongs_to :student
  
  validates :student_name, :presence => true
  validates :assignment_name, :presence => true
  validates :score, :presence => true, numericality: true
  validates :total, :presence => true, numericality: true
  
  
  def percentage
    percentage = (score * 100) / total
    return percentage
  end
  
  def self.average_percentage
    assignments = all
    
    sum = 0
    assignments.each{ |x| sum += x.percentage}
    return 0 if sum == 0
    percentage_total = sum / assignments.size
  end
  
  
end