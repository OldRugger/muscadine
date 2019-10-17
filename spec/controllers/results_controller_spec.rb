require 'rails_helper'
require "rspec/json_expectations"

RSpec.describe ResultsController, type: :controller do

  describe "GET classes" do
    it "shoule return available classes" do
      get :classes
      expect(response).to have_http_status(:ok)
      expect(response.body).to include_json("classes":["ISVM","ISVF","ISJVM","ISJVF","ISIM","ISIF","ISPM","ISPF"])
    end
  end

  describe "Get Calculated results" do
    before(:all) do
      # preload the runners and teams
      Runner.import(fixture_file_upload("OE0010_import_test_data.csv"))
      Team.import(fixture_file_upload("teams.csv"))
      source = file_fixture("OE0013_two_day_results.csv")
      @target = File.join(".", "tmp/OE0013_two_day_results.csv")
      FileUtils.cp(source, @target)
      TeamResults.new.perform([@target])
    end

    it "should for both days of a two day met" do
      get :awt
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response.count).to eq(2)
      day1 = json_response["1"]
      expect(day1.count).to eq(30)
      expect(day1["ISVM"]).to eq("0:56:41")
      day2 = json_response["2"]
      expect(day2.count).to eq(30)
      expect(day2["ISVF"]).to eq("1:08:50")
    end

    it "should return results for all teams" do
      get :teams
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response["awt"].count).to eql(2)
      expect(json_response["awt"]["day1"].count).to eql(43)
      expect(json_response["awt"]["day2"].count).to eql(43)
      expect(json_response["awt"]["day1"]["Hogwarts Varsity Silver"]["results"]).to eql("Doe_121 (80.845), Doe_127 (81.568), Doe_102 (97.709)")
      expect(json_response["awt"]["day2"]["Hogwarts Varsity Silver"]["results"]).to eql("Doe_121 (64.315), Doe_127 (71.212), Doe_102 (76.844)")
    end
  end

end