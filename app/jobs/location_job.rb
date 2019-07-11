class LocationJob < ApplicationJob
  @queue = :location_job

  def perform(location_id)
    LocationService.new(location_id).call

  end
end
