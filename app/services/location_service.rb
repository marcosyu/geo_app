class LocationService

  def initialize(location_id)
    @@location = Location.find(location_id)
    @@geo_location = get_geo_location
    @@polygons = given_polygons

  end

  def call
    results = []
    @@polygons.each do |polygon|
      results << inside_this_polygon?(polygon)
    end

    @@location.update_attributes({
                                   lat: @@geo_location["lat"],
                                   lng: @@geo_location["lon"],
                                   inside?: results.include?(true)
    })
    return @@location
  end

  private

  def get_geo_location
    Geocoder.search(@@location.name).first.data
  end

  def given_polygons
    coordinates = JSON.parse(File.read("#{Rails.root}/lib/Given_areas.json"))["features"]
    polygons = coordinates.map{|coordinate| coordinate["geometry"]["coordinates"]}

    return polygons.flatten(1)
  end

  def inside_this_polygon?(coordinates)
    #ray casting
    x = @@geo_location["lon"].to_f
    y = @@geo_location["lat"].to_f

    last_coordinate = coordinates[-1]
    oddCorner = false

    coordinates.each do |coordinate|
      yi = coordinate[0]
      xi = coordinate[1]
      yj = last_coordinate[0]
      xj = last_coordinate[1]

      if yi < y && yj >= y ||
          yj < y && yi >= y
        oddCorner = !oddCorner if xi + (y - yi) / (yj - yi) * (xj - xi) < x
      end

      last_coordinate = coordinate
    end

    return oddCorner
  end

end
