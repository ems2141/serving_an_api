class CarsController < ActionController::Base
  def index
    @cars = Car.all
  end

  def show
    @car = Car.find(params[:id])
  end
end