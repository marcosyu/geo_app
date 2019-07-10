FactoryBot.define do
  factory :location do
    lat { FFaker::Geolocation.lat }
    lng { FFaker::Geolocation.lng }
    name { FFaker::Name.name }
    inside? {FFaker::Boolean.maybe }
  end
end
