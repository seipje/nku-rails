class StudentsController < ApplicationController
  
  skip_before_action :require_login, only: [:new, :create]
  
  def new
    @student = Student.new
  end
  
  def create
    @student = Student.create!(student_params)
    session[:student_id] = @student.id
    
    if(params[:student][:image_url].empty?)
      require 'digest/md5'
      email_address = params[:student][:email].downcase
      hash = Digest::MD5.hexdigest(email_address)
      params[:student][:image_url] = "http://www.gravatar.com/avatar/#{hash}"
    end
    
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
    @desired_date = params[:desired_date] || Date.today
    @present_students = Student.present
   
    @in_seat_1 = Student.in_seat(1, @desired_date)
    @in_seat_2 = Student.in_seat(2, @desired_date)
    @in_seat_3 = Student.in_seat(3, @desired_date)
    @in_seat_4 = Student.in_seat(4, @desired_date)
    @absent = Student.absent(@desired_date)
  end

  private

  def student_params
    params.require(:student).permit!
  end
end