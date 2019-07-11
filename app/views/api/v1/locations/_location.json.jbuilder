json.type "Feature"
json.geometry do 
  json.type "Point"
  json.coordinates [location.lat, location.lng]
end
json.properties do
  json.name location.name
  json.inside? location.inside?
end