json.FeatureCollection do
  json.array! @locations do |location|
	 json.partial! location, as: :location
  end
end