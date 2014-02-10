class SessionsController < ApplicationController
  def index
    
    current_student = get_current_student
    if(current_student != nil)
      redirect_to students_path
    end
   
    @student = Student.new
  end
  
  def login
    
    @student = Student.find_by_name(params[:student][:name])
    
    if( @student && @student.authenticate( params[:student][:password] ) )
     
      session[:student_id] = @student.id
      redirect_to students_path
    else
     
      @student = Student.new
      flash.now.notice = "Invalid email or password"
      render 'index'
    end
    
  end
  
  def logout
    
    session[:student_id] = nil
    redirect_to students_path
  end
  
end