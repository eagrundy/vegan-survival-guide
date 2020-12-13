class RestaurantsController < ApplicationController
    # CRUD

    # READ
    # index, route for all restaurants posts
    get '/restaurants' do
        @restaurants = Restaurant.all
        # render all restaurants posts
        erb :'restaurants/index'
    end

    
    # CREATE
    # render a form to create a new post
    get "/restaurants/new" do
        erb :"restaurants/new"
    end

    post "/restaurants" do
        restaurant = Restaurant.create(name: params[:name], options: params[:options], source: params[:source], image_url: params[:image_url], user_id: current_user.id)
        redirect "/restaurants/#{post.id}"
    end
    
    
    # show route for a single restaurant post
    get '/restaurants/:id' do
        # find the post
        @restaurant = Restaurant.find(params[:id])
        erb :"/restaurants/show"
    end

    

end