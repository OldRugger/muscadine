require 'rails_helper'

RSpec.describe TeamsController, type: :controller do

  describe "POST import teams" do
    before(:all) do
      # preload the runners
      Runner.import(fixture_file_upload("OE0010_import_test_data.csv"))
    end
    it "should import teamss " do
     post :import, :params => { :file =>fixture_file_upload("teams.csv") }
      expect(response).to have_http_status(:created)
      expect(response.body).to include_json("teams":38,"members":162)
    end

    it "should fail if no file is specified" do
      post :import, :params => { }
      expect(response).to have_http_status( :unprocessable_entity)
    end
  end

end
