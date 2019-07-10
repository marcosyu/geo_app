class LocationJob < ApplicationJob
  @queue = :location_job

  def perform(id)
    location = Location.find(id)
    geo_location = Geocoder.search(location.name).first
    is_inside = LocationService.new(geo_location).call
    byebug
    location.update_attributes({
                                 lat: geo_location.data["lat"],
                                 lng: geo_location.data["lon"],
                                 inside?: is_inside
    })
  end
end
