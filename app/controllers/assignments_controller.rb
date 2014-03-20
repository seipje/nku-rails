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
    else
      @assignments = Assignment.find(:all, :conditions => {:student_name => @current_student.name})
    end
    #@average_grade = @assignments.average_percentage
  end
  
   private

  def assignment_params
    params.require(:assignment).permit!
  end
  
end