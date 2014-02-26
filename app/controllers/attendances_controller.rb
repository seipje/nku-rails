class AttendancesController < ApplicationController
  def index
    if(params[:student_id])
      @desired_student = Student.find(params[:student_id])
      @attendances = Attendance.where(student: @desired_student)
    else
      @attendances = Attendance.all
    end
    
    @students = Student.all
    
    @in_seat_1 = Student.in_seat(1, @desired_date)
    @in_seat_2 = Student.in_seat(2, @desired_date)
    @in_seat_3 = Student.in_seat(3, @desired_date)
    @in_seat_4 = Student.in_seat(4, @desired_date)
    @absent = Student.absent(@desired_date)
  end
  
  def new
    @current_student = current_student
     if !@current_student
      redirect_to login_page_path
    end
    @attendance = Attendance.new
  end
  
  def create
    @attendance = Attendance.new(attendance_params)
    if @attendance.save
      redirect_to students_path
      flash[:notice] = "You have recorded your attendance!"
    else
         
      render 'new'
    end
  end
  
  private
  def attendance_params
    @current_student = current_student
    params[:attendance][:student_id] = @current_student.id
    params[:attendance][:attended_on] = Date.today
    params.require(:attendance).permit(:seat, :student_id, :attended_on)
  end
end
