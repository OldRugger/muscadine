require 'yaml'

class ConfigController < ApplicationController

  def index
    if Config.count == 0
      load
    end
    render json: Config.last
  end

  def show
    render json: Config.find(params[:id])
  end

  def update
    config = Config.find(params[:id])
    config.update(config_params)
    config.save
    render json: config.to_json, status: :accepted
  end

  def persist
    config = Config.last
    current_config = YAML.load_file("#{Rails.root}/config/config.yml")
    current_config["test"]["title"] = config.title
    current_config["test"]["hotfolder"] = config.hotfolder
    current_config["test"]["max_time"] = config.max_time
    File.open("#{Rails.root}/config/config.yml", "w") { |file| file.write(current_config.to_yaml) }
  end

  def load
    Config.load
  end

  def config_params
    params.require(:config).permit(:title, :hotfolder, :max_time, :unique_id, :day, :firstname, :lastname, :entry_class, :gender, :classifier, :time, :school, :team, :jrotc)
  end
end
