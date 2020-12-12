class RestaurantsController < ApplicationController

    get '/restaurants' do
        @restaurants = Restaurant.all

        erb :'restaurants/index'
    end

    get '/restaurants/:id' do
        @restaurant = Restaurant.find(params[:id])
        erb :'/restaurants/show'
    end


end