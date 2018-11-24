module API
  class Cars::API < Grape::API
    rescue_from ActiveRecord::RecordNotFound do |e|
      error!('Record Not Found', 404)
    end

    version 'v1', using: :header, vendor: 'dry'
    format :json
    prefix :api

    resource :cars do
      desc 'Returns all cars'
      get  do
        Car.all
      end

      desc 'Returns a car'
      params do
        requires :id, type: Integer, desc: 'ID'
      end
      route_param :id do
        get do
          Car.find(params[:id])
        end
      end

      desc 'Create a car'
      params do
        requires :make, type: String, desc: 'Make'
        requires :model, type: String, desc: 'Model'
        requires :year, type: Integer, desc: 'Year'
        requires :engine_size, type: Float, desc: 'Engine Size'
        requires :description, type: String, desc: 'Description'
      end
      post do
        validator = CarValidator::CarSchema.call(params)
        if validator.success?
          Car.create!(params)
        else
          validator.errors
        end
      end

      desc 'Update a car'
      params do
        requires :id, type: Integer, desc: 'ID'
        optional :make, type: String, desc: 'Make'
        optional :model, type: String, desc: 'Model'
        optional :year, type: Integer, desc: 'Year'
        optional :engine_size, type: Float, desc: 'Engine Size'
        optional :description, type: String, desc: 'Description'
      end
      put ':id' do
        car = Car.find(params[:id])
        validator = CarValidator::CarSchema.call(params)
        if validator.success?
          car.update(params)
        else
          validator.errors
        end
      end

      desc 'Delete a car'
      params do
        requires :id, type: Integer, desc: 'ID'
      end
      delete ':id' do
        Car.find(params[:id]).destroy
      end
    end
  end
end
