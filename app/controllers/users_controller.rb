class UsersController < ApplicationController

    get '/login' do
        erb :login
    end

    post '/login' do
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        else
            redirect '/login'
        end
    end

    get '/users/:id' do
        @user = User.find_by(id: params[:id])
        # erb :'/users/show'
    end

    get '/signup' do
        erb :signup
    end

    post '/users' do
        @user = User.new(params)
        if @user.save
        session[:user_id] = @user.id
        redirect "/users/#{@user.id}"
        else
            redirect '/signup'
    end

    get '/logout' do
        # binding.pry
        session.clear
        # binding.pry
        redirect '/'
    end
end
end