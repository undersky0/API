require 'rails_helper'

RSpec.describe "V1::ItemLines", :type => :request do
  describe "GET /v1_item_lines" do
    it "works! (now write some real specs)" do
      get v1_item_lines_path
      expect(response).to have_http_status(200)
    end
  end
end
