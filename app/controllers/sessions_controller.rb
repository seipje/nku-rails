class SessionsController < ApplicationController
def new
end
  
def create
  student = Student.find_by_email(params[:name])
  if student && student.authenticate(params[:password])
    session[:student_id] = student.id
    redirect_to students_path, :notice => "Logged in!"
   else
     flash.keep[:notice]="Invalid email or password"
     render "show"
   end
end
def destroy
  session[:student_id] = nil
    redirect_to students_path, :notice => "Logged out!"
 end
end