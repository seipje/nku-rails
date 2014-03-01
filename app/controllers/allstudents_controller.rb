class AllstudentsController < ApplicationController

  def index
    @students = Student.all
  end
  
end