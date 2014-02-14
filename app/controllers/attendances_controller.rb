class AttendancesController < ApplicationController
  def index
    now = Date.today
    @in_seat_1 = Student.in_seat(1, now)
    @in_seat_2 = Student.in_seat(2, now)
    @in_seat_3 = Student.in_seat(3, now)
    @in_seat_4 = Student.in_seat(4, now)
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
      flash[:notice] = "You have recorded your attendance!"
      redirect_to attendances_path
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
