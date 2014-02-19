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
    
     now = Date.today
    @in_seat_1 = Student.in_seat(1, now)
    @in_seat_2 = Student.in_seat(2, now)
    @in_seat_3 = Student.in_seat(3, now)
    @in_seat_4 = Student.in_seat(4, now)
    @absent = Student.absent(now)
  end

  private

  def student_params
    params.require(:student).permit!
  end
end