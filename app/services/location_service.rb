class LocationService

  def initialize(location_params)
    @@location = location_params
  end

  def call
    return true
  end

  private

  def polygon
    areas = JSON.parse(File.read("#{Rails.root}/lib/Given_areas.json"))["features"]
    return areas.map{|area| area["geometry"]["coordinates"]}
  end

end
