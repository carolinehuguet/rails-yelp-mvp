class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    ## Strong paramameters
    @restaurant = Restaurant.new(restaurant_params)

    ## If a validation prevents to save the data,
    ## We want to render the "new" view with the form, FROM the create action
    ## The @restaurant here will then be the one used by the "new" view
    ## It means the form will still be filled with the data you entered
    if @restaurant.save
      redirect_to(restaurant_path(@restaurant))
    else
      render :new
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])

    ## If a validation prevents to update the data,
    ## We want to render the "edit" view with the form, FROM the update action
    ## The @restaurant here will then be the one used by the "edit" view
    ## It means the form will still be filled with the changes you already entered
    if @restaurant.update(restaurant_params)
      redirect_to(restaurant_path(@restaurant))
    else
      render :edit
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy

    redirect_to(restaurants_path)
  end

  private
  ## Strong params: we take only params[:restaurant]
  ## In params[:restaurant], we only take the key that will help us create a new restaurant
  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :category, :phone_number)
  end

end
