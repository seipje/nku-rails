require '~/nku-rails/spec/spec_helper'

class StudentsController < ApplicationController
  
  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to students_path, :notice => "Welcome #{@student.name}!"
    else
      render "new"
    end
  end
  
  def index
    @student = Student.all
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
