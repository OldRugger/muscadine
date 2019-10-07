require 'rails_helper'
require "rspec/json_expectations"

RSpec.describe RunnersController, type: :controller do

  describe "POST import runners" do
    it "should import runners " do
     post :import, :params => { :file =>fixture_file_upload("OE0010_import_test_data.csv") }
      expect(response).to have_http_status(:created)
      expect(response.body).to include_json("added":180,"skipped":249)
    end

    it "should fail if no file is specified" do
      post :import, :params => { }
      expect(response).to have_http_status( :unprocessable_entity)
    end
  end

end
