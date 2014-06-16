require 'rails_helper'

describe "Cars API" do
  describe 'GET /cars' do
    it 'returns a list of cars' do
      ford = create_make(name: "Ford")
      chevy = create_make(name: "Chevy")

      ford_car = create_car(
          color: "red",
          doors: 4,
          make_id: ford.id,
          purchased_on: Time.parse("1973-10-04")
      )
      chevy_car = create_car(
          color: "blue",
          doors: 2,
          make_id: chevy.id,
          purchased_on: Time.parse("2012-01-24")
      )

      get '/cars', {}, {'Accept' => 'application/json'}

      expected_response = {
          "_links" => {
              "self" => {"href" => cars_path},
          },
          "_embedded" => {
              "cars" => [
                  {
                      "_links" => {
                          "self" => {"href" => car_path(ford_car)},
                          "make" => {"href" => make_path(ford)},
                      },
                      "id" => ford_car.id,
                      "color" => "red",
                      "doors" => 4,
                      "purchased_on" => "1973-10-04"
                  },
                  {
                      "_links" => {
                          "self" => {"href" => car_path(chevy_car)},
                          "make" => {"href" => make_path(chevy)},
                      },
                      "id" => chevy_car.id,
                      "color" => "blue",
                      "doors" => 2,
                      "purchased_on" => "2012-01-24"
                  },
              ]
          },
      }

      expect(response.code.to_i).to eq(200)
      expect(JSON.parse(response.body)).to eq(expected_response)
    end
  end

  describe 'GET cars/:id' do
    it 'shows one car' do
      ford = create_make(name: "Ford")

      ford_car = create_car(
          color: "red",
          doors: 4,
          make_id: ford.id,
          purchased_on: Time.parse("1973-10-04")
      )

      get "/cars/#{ford_car.id}", {}, {'Accept' => 'application/json'}

      expected_response = {
          "_links" => {
              "self" => {"href" => car_path(ford_car)},
              "make" => {"href" => make_path(ford)},
          },
          "id" => ford_car.id,
          "color" => "red",
          "doors" => 4,
          "purchased_on" => "1973-10-04"
      }

      expect(response.code.to_i).to eq(200)
      expect(JSON.parse(response.body)).to eq(expected_response)
    end
  end
end