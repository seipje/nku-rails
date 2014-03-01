class SessionsController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]
    
  def new
  end
    
  def create
    student = Student.find_by_email(params[:session][:email])
   
    if student && student.authenticate(params[:session][:password])
      session[:student_id] = student.id
      redirect_to students_path, :notice => "Welcome, #{student.name}!"
    else
       flash.keep[:notice]="Invalid email or password"
       render "new"
    end
  end
    
  def logout
    session[:student_id] = nil
    redirect_to students_path, :notice => "Logged out!"
  end
  
  
  helper_method :current_student
  def current_student
    @current_student ||= Student.find(session[:student_id]) if session[:student_id].present?
  end
end