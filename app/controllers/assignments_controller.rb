class AssignmentsController < ApplicationController
  
  def new
    @current_student = current_student
    @assignment = Assignment.new
    
    if !@current_student.admin?
      redirect_to students_path
      flash[:notice] = "Unauthorized"
    end
  end
  
  def create
    @assignment = Assignment.create!(assignment_params)
    
    redirect_to students_path, notice: "#{@assignment.assignment_name} successfully created!"
  end
  
  def index
    @current_student = current_student
    
    if @current_student && @current_student.admin?
      @assignments = Assignment.all
    elsif @current_student
      @assignments = Assignment.find(:all, :conditions => {:student_name => @current_student.name})
      # This is where I'd put the logic to only show the average for the current student's grades
      #@average_grade = Assignment.average_percentage
    else
      redirect_to students_path, notice: "Unauthorized!"
    end
    
    # I know that this is showing the percentage for all the grades. But I can't figure out how to 
    # get it to work right. I didn't start this assignment soon enough and now I'm out of time.
    @average_grade = Assignment.average_percentage
  end
  
   private

  def assignment_params
    params.require(:assignment).permit!
  end
  
end