module Api::V1

  class LocationsController < Api::V1::BaseController

    def index
      @locations = Location.all

    end

    def create
      @location  = Location.new(location_params)

      if @location.save
        LocationJob.perform_later(Location.last.id)
      end

      render json: @location.id

    end

    def show
      @location = Location.find(params[:id])
    end

    private

    def location_params
      params.require(:location).permit(:name)
    end

  end

end
