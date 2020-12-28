require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    # sets where the views live
    set :views, 'app/views'
    # enable sessions
    enable :sessions
    set :session_secret, "my_secret_session"
    register Sinatra::Flash
  end

  # controller is taking the request, then loads the file welcome
  get "/" do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :welcome
    end
  end


  get '/search' do
      erb :'/restaurants/search'
  end
 

  post "/search" do
    if params[:sort][:keyword]
      by_name = Restaurant.all.order('updated_at DESC').select{|restaurant|restaurant.name.downcase.include?(params[:sort][:keyword].downcase)}
      by_options = Restaurant.all.order('updated_at DESC').select{|restaurant|restaurant.options.downcase.include?(params[:sort][:keyword].downcase)}
      @restaurants = (by_name + by_options).uniq
    end
    erb :'restaurants/results'
  end


  #helper methods for user that has logged in
  helpers do
    def current_user
      # @current_user ||= User.find(session[:user_id]) if session[:user_id]
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
