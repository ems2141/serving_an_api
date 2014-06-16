class CarsController < ActionController::Base
  def index
    @cars = Car.all
  end

  def show
    @car = Car.find(params[:id])
  end

  def create
    if User.find_by(api_authentication_token: request.headers['Authorization'])
      attributes = JSON.parse(request.body.read)
      @car = Car.create(attributes)

      render status: 201
    end
  end
end