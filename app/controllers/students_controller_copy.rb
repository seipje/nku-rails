require '~/nku-rails/spec/spec_helper'

class StudentsController < ApplicationController

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
        

    
    #respond_to do |format|
      
   #   if @student.save && @student.authenticate(params[:password])
   #     session[:student_id] = @student.id
#        format.html {redirect_to students_path, notice: "Welcome back, #{@student.name}" }
   #   else
   #     format.html { render action: "new" }
    #  end

  
      if @student.save
        redirect_to index, :notice => "Signed up!"
      else
          render "new"
      end
     # if @student && @student.authenticate(params[:password])
    #    session[:student_id] = @student.id
     #  redirect_to students_path, :notice => "Welcome back, #{@student.name}"
    #  else
    #    flash.now.alert = "Invalid email or password"
    #    render "new"
    #  end
      
      #if @student.save
    #    format.html { redirect_to students_path, notice: 'New student was successfully created!' }
     # else
     #   format.html { render action: "new" }
     # end
  # end
  end

  def show
    @students = Student.all
      #find(params[:id])
  end

  def index
    @students = Student.all
  end

  def edit
    @student = Student.find(params[:id])
  end
  
  
  def update
    @student = Student.find(params[:id])
  
    if @student.update(params[:student].permit(:name, :password, :nickname, :email, :imageURL))
      redirect_to students_path, notice: 'Your profile was successfully updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
 
    redirect_to students_path
  end


private
  def student_params
    params.require(:student).permit(:name, :password, :password_confirmation, :nickname, :email, :imageURL)
  end
  
end
