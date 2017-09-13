Rails.application.routes.draw do

  # root :to   => 'landing#index'

  devise_for :users
  #, :controllers => { omniauth_callbacks: 'omniauth_callbacks', sessions: 'users/sessions' }, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/files/*path' => 'gridfs#serve'

  resources :venues
  resources :events
  resources :users
end
