require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    # enable sessions
    enable :sessions
    set :session_secret, "my_secret_session"
    register Sinatra::Flash
  end

  get "/" do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :welcome
    end
  end

  #helper methods for user that has logged in
  helpers do
    def current_user
      User.find_by(id: session[:user_id])
      # User.find(session[:user_id])
    end
    
    #returns a boolean
    def logged_in?
      #current_user will return nil or the entire user object (we want true/false)
      !!current_user
    end

    def redirect_if_not_logged_in
      if !logged_in?
        flash[:errors] = "You must log in to view this page!"
        redirect '/login'
      end
    end

    def authorized_to_edit?(restaurant)
      restaurant.user == current_user
    end
  end
end
