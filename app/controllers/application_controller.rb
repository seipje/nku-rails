class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :require_login

  helper_method :current_student
  def current_student
    @current_student ||= Student.find(session[:student_id]) if session[:student_id].present?
  end
  
  
  private
 
  def require_login
    unless session[:student_id] != nil
      redirect_to login_page_path # halts request cycle
    end
  end
  
end