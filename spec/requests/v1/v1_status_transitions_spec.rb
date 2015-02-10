require 'rails_helper'

RSpec.describe "V1::StatusTransitions", :type => :request do
  describe "GET /v1_status_transitions" do
    it "works! (now write some real specs)" do
      get v1_status_transitions_path
      expect(response).to have_http_status(200)
    end
  end
end
