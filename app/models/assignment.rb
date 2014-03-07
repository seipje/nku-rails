class Assignment < ActiveRecord::Base 
  
  def percentage
    (score * 100) / total
    return 0 if sum == 0
  end
  
  def self.average_percentage
    assignments = all
    
    sum = 0
    assignments.each{ |x| sum += x.percentage}
    return 0 if sum == 0
    percentage_total = sum / assignments.size
  end
  
  
end