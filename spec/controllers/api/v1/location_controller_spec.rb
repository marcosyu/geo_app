require 'rails_helper'

RSpec.describe Api::V1::LocationsController, type: :controller do
  include ActiveJob::TestHelper
  before(:all) do
    Location.destroy_all
  end
  after(:all) do
    Resque.remove_queue('location_job')
  end

  describe "GET all" do

    it "shows all locations" do
      location = FactoryBot.create(:location)
      get :index, {format: :json}
      content = JSON.parse(response.body)
      expect(content["FeatureCollection"][0]["properties"]["name"]).to eql location.name
    end
  end

  describe "POST location" do
    let (:params){
      {
        location:{
          name: FFaker::Address.city
        }
      }
    }

    it "enqeues the location" do
      post :create, params: params
      content = response.body
      expect(Resque.queues.size).to eq 1
      expect(response.body.to_i).to eql Location.first.id

    end
  end

  describe "GET one location" do
    let(:location) { FactoryBot.create(:location) }

    it "shows one location" do
      get :show, {params: {id: location.id}, format: :json}
      content = JSON.parse(response.body)
      expect(content["properties"]["name"]).to eql location.name

    end
  end
end
