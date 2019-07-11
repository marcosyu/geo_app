require "rails_helper"

RSpec.describe LocationService, :type => :job do

  before(:all) do
    Location.destroy_all
    Geocoder.configure(lookup: :test, ip_lookup: :test)

    Geocoder::Lookup::Test.add_stub(
      "New York, NY", [
        {
          'lat'          => 40.7143528,
          'lon'          => -74.0059731,
          'address'      => 'New York, NY, USA',
          'state'        => 'New York',
          'state_code'   => 'NY',
          'country'      => 'United States',
          'country_code' => 'US'
        }
      ]
    )
  end

  describe "call location service" do
    it "populate coordinates and inside?" do
      location = FactoryBot.create(:location)
      updated_location = LocationService.new(location.id).call
      expect(updated_location.lat.to_f).to eql 40.7143528
      expect(updated_location.lng.to_f).to eql -74.0059731
      expect(updated_location.inside?).to eql false
    end
  end
end
