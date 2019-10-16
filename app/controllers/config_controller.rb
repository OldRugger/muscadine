require 'yaml'

class ConfigController < ApplicationController

  def index
    if config.count = 0
      load_config
    end
    render json: Config.last
  end

  def show
    render json: Config.find(params[:id])
  end

  def update
    config = Config.find(params[:id])
    config.update(config_params)
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

  def load_config
    config = Config.new
    config.title = APP_CONFIG[:title]
    config.hotfolder = APP_CONFIG[:hotfolder]
    config.max_time = APP_CONFIG[:max_time]
    config.save
  end

  def config_params
    params.require(:config).permit(:title, :hotfolder, :max_time)
  end
end
