require 'rails_helper'

RSpec.describe ConfigController, type: :controller do

  describe "get config initial " do
    before do
      Config.delete_all
    end
    it "should load the config from yaml if no record found" do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.body).to include_json("title":"2020 Test","hotfolder":"results","max_time":180)
    end
  end

  describe "get config" do
    let(:config) {
      config = Config.new({title: "2020 Test new"})
      config.save
      config
    }
    it "should return config from database" do
      get :show, params: { id: config.id }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include_json("title":"2020 Test new")
    end
  end

  describe "update config " do
    let(:config) {
      config = Config.new({title: "2020 Test new"})
      config.save
      config
    }
    it "update config " do
      put :update, params: { id: config.id, config: {title: "2020 Test updated" } }
      expect(response).to have_http_status(:accepted)
      expect(response.body).to include_json("title":"2020 Test updated")
    end
  end

  describe "persist config " do
    before do
      Config.delete_all
      config = Config.new({title: "2020 Test", hotfolder: "results", max_time: 180})
      config.save
    end
    it "should write config to config.yml" do
      post :persist
      persist = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env].to_json
      time = File.mtime("#{Rails.root}/config/config.yml")
      expect(persist).to include_json("title":"2020 Test","hotfolder":"results","max_time":180)
      expect(time).to be_within(5.second).of Time.now
    end
  end
  describe "load config from yaml" do
    it "should write config to config.yml" do
      post :load
      expect(Config.count).to eq(1)
      expect(Config.last.as_json).to include_json("unique_id": "Stno", "firstname": "First name",
             "lastname": "Surname", "entry_class": "Short", "classifier": "Classifier", "time": "Time",
             "school": "Text2", "team": "Text3", "jrotc": "Text1" )
    end
  end

end
