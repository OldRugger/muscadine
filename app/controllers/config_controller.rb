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
    Config.delete_all
    app_config = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]
    app_config.symbolize_keys!
    config = Config.new
    load_config_values(config, app_config)
    config.save
  end

  def load_config_values(config, app_config)
    config.title = app_config[:title]
    config.hotfolder = app_config[:hotfolder]
    config.max_time = app_config[:max_time]
    input = app_config[:input].symbolize_keys
    config.day = input[:day]
    fields = input[:fields].symbolize_keys
    set_input_fields(config, fields)
  end

  def set_input_fields(config, fields)
    config.unique_id   = fields[:unique_id]
    config.firstname   = fields[:firstname]
    config.lastname    = fields[:lastname]
    config.entry_class = fields[:entry_class]
    config.gender      = fields[:gender]
    config.classifier  = fields[:classifier]
    config.time        = fields[:time]
    config.school      = fields[:school]
    config.team        = fields[:team]
    config.jrotc       = fields[:jrotc]
  end

  def config_params
    params.require(:config).permit(:title, :hotfolder, :max_time)
  end
end
