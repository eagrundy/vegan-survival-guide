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
    # get 'post/new' render a form to create a new post
    get "/restaurants/new" do
        redirect_if_not_logged_in
        erb :"restaurants/new"
    end

    # post route to create a new post
    post "/restaurants" do
        # receive the params that the user input in the create new restaurant form
        @restaurant = Restaurant.new(name: params[:name], options: params[:options], source: params[:source], image_url: params[:image_url], user_id: current_user.id)
        if @restaurant.save
            flash[:message] = "Restaurant successfully created!"
            redirect "/restaurants/#{post.id}"
        else
            flash[:errors] = "Restaurant creation failure: #{@restaurant.errors.full_messages.to_sentence}"
            redirect '/restaurants/new'
        end
    end
    
    
    # show route for a single restaurant post
    get '/restaurants/:id' do
        # find the post
        # id is coming from url - params
        find_restaurant
        erb :'restaurants/show'
    end

    # UPDATE
    # create link to edit form on restaurant show page
    # get posts/edit to render a form to edit a post
    get '/restaurants/:id/edit' do
        redirect_if_not_logged_in
        find_restaurant
        if authorized_to_edit?(@restaurant)
            erb :'/restaurants/edit'
          else
            # flash[:errors] = "Not authorized to edit."
            redirect "/restaurants/#{@restaurant.id}"
          end
        end

    # patch route to update existing post
    patch '/restaurants/:id' do
        find_restaurant
        @restaurant.update(name: params[:name], options: params[:options], source: params[:source], image_url: params[:image_url])
        redirect "/restaurants/#{@restaurant.id}"
    end

    # DELETE
    # delete route to delete an existing restaurant
    delete '/restaurants/:id' do
        # we need the id to FIND the restaurant to delete
        find_restaurant
        if authorized_to_edit?(@restaurant)
            @restaurant.destroy
            flash[:message] = "Successfully deleted!"
            redirect '/restaurants'
        else
            flash[:errors] = "You're not authorized to delete this restaurant."
            redirect "/restaurants/#{@restaurant.id}"
        end
    end

    private

    def find_restaurant
        @restaurant = Restaurant.find(params[:id])
      end
end