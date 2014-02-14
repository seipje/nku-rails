class StudentsController < ApplicationController
  def new
    @student = Student.new
  end
  
  def create
    @student = Student.create!(student_params)
    session[:student_id] = @student.id
    redirect_to students_path, notice: "Hi #{@student.name}. Welcome to Bueller!"
  end

  def edit
    @current_student = current_student
    
    if(@current_student == nil)
      # They're not logged in
      redirect_to students_path, notice: "You must be logged in to edit your info."
    end
    
    @student = @current_student
  end

  def update
    current_student.update_attributes!(student_params)
    redirect_to students_path, notice: "Successfully updated your profile"
  end

  def index
    @current_student = current_student
    @students = Student.all
  end

  private

  def student_params
    params.require(:student).permit!
  end
end