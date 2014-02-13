class SessionsController < ApplicationController
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
  
end