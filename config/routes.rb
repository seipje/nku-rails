NkuRails::Application.routes.draw do
  #get "attendance/index"

  resources :students, except: :edit do
    resources :attendances
  end
 
  resources :sessions
  resources :attendances
  resources :allstudents
  resources :assignments
  
  get "sign_out", to: "sessions#destroy"
  get "profile", to: "students#edit"
  
  
  get 'login', to: "sessions#new", as: :login_page 
  post 'login/process', to: "sessions#create", as: :login_process
  get 'logout', to: "sessions#logout", as: :logout
  get "edit", to: "students#edit", as: :edit
  
  get "attendance", to: "attendances#new", as: :get_attendance
  post "attendance/process", to: "attendances#create", as: :post_attendance
  
  #post "upload", to: "students/upload", as: :upload_students
  
 


  root to: "students#index"
end