class Config < ApplicationRecord
  def self.load
    Config.delete_all
    app_config = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]
    app_config.symbolize_keys!
    config = Config.new
    self.load_config_values(config, app_config)
    config.save
  end

  def self.load_config_values(config, app_config)
    config.title = app_config[:title]
    config.hotfolder = app_config[:hotfolder]
    config.max_time = app_config[:max_time]
    input = app_config[:input].symbolize_keys
    config.day = input[:day]
    fields = input[:fields].symbolize_keys
    set_input_fields(config, fields)
  end

  def self.set_input_fields(config, fields)
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

end
