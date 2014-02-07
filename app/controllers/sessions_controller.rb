class SessionsController < ApplicationController
def new
end
  
def create
  student = Student.find_by_email(params[:name])
  if student && student.authenticate(params[:password])
    session[:user_id] = user.id
    redirect_to students_path, :notice => "Logged in!"
   else
     flash.keep[:notice]="Invalid email or password"
     render "show"
   end
end
def destroy
    session[:user_id] = nil
    redirect_to students_path, :notice => "Logged out!"
 end
end