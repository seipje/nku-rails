require '~/nku-rails/spec/spec_helper'

class StudentsController < ApplicationController
  
  def new
    @current_student = get_current_student
    
    if(@current_student != nil)
      redirect_to students_path
    end
    
    @student = Student.new
  end

  def create
    if(params[:student][:name].empty?)
      params[:student][:name] = "placeholder@example.com"
    end
    
    #Gravatar
    if(params[:student][:image_url].empty?)
      require 'digest/md5'
      email_address = params[:student][:email].downcase
      hash = Digest::MD5.hexdigest(email_address)
      params[:student][:image_url] = "http://www.gravatar.com/avatar/#{hash}"
    end
    
    @student = Student.new(student_params)
    if @student.save
        
      #Log in
      session[:student_id] = @student.id
        
      redirect_to students_path, notice: "Student successfully added!"
    else
      redirect_to 'new'
    end
  end
  
  def index
    @student = Student.all
    @current_student = get_current_student
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
 
    redirect_to students_path
  end

  def edit
    @current_student = get_current_student
    @student = Student.find(params[:id])
    
    if(@current_student == nil)
      redirect_to students_path, notice: "You must be logged in to do that."
    elsif( @current_student.id != @student.id )
      redirect_to students_path, notice: "You are not authorized to do that."
    end
    
  end
  
  def update
    @student = Student.find(params[:id])
    @current_student = get_current_student
    
    
    if(@current_student == nil)
      redirect_to students_path, notice: "You must be logged in to do that."
    elsif(@current_student.id != @student.id)
      redirect_to students_path, notice: "You are not authorized to do that."
    end
  
    if(params[:student][:email].empty?)
      params[:student][:email] = "placeholder@example.com"
    end
    
    #Gravatar
    if(params[:student][:image_url].empty?)
      require 'digest/md5'
      email_address = params[:student][:email].downcase
      hash = Digest::MD5.hexdigest(email_address)
      params[:student][:image_url] = "http://www.gravatar.com/avatar/#{hash}"
    end
    
    if @student.update(student_params)
      redirect_to students_path, notice: "Student was successfully updated!"
    else
      render 'edit'
    end
  end

private
  def student_params
    params.require(:student).permit(:name, :password, :password_confirmation, :nickname, :email, :imageURL)
  end
end
