class UsersController < ApplicationController

    get '/login' do
        erb :'/users/login'
    end

    #create a session
    post '/login' do
        # Receive the input from the login form
        # Find the user
        @user = User.find_by(email: params[:email])
        # authenticate user
        if @user && @user.authenticate(params[:password])
            # log user in, creating a session, adding a key/value pair to session hash
            session[:user_id] = @user.id
            flash[:message] = "Welcome back, #{@user.name}!"
            # always flash-message before redirect
            # goes to user profile
            redirect "/users/#{@user.id}"
        else
            # Show an error message
            flash[:errors] = "Invalid email and/or password! Try again!"
            #redirect to login form
            redirect '/login'
        end
    end

    # user Show route
    get '/users/:id' do
    #finds the user
        @user = User.find_by(id: params[:id])
        erb :'/users/show'
    end

    #render sign up form
    get '/signup' do
        erb :'/users/signup'
    end

    #create new user using sign up form
    post '/users/signup' do
        @user = User.new(params)
        # User.create(name: params[:name], email: params[:email], password: params[:password], bio: params[:bio])
        #log user in, creating a session, adding a key/value pair to session hash
        if @user.save
            session[:user_id] = @user.id
            flash[:message] = "Welcome, #{@user.name}!"
            redirect "/users/#{@user.id}"
        else
            # Invalid input
            flash[:errors] = "Failure to create account: #{@user.errors.full_messages.to_sentence}"
            redirect '/signup'
        end
    end

    
    #logs out user by emptying session hash
    get '/logout' do
        # binding.pry
        session.clear
        redirect '/'
    end
end