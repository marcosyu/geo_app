require "rails_helper"

RSpec.describe LocationJob, :type => :job do

  describe "perform job" do
    include ActiveJob::TestHelper

    let(:location) { FactoryBot.create(:location) }

    it "populate coordinates and inside?" do

      LocationJob.perform_now(location.id)
    end
  end
end
