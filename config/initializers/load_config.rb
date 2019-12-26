require 'fileutils'

# # load config and start Listener
APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]
APP_CONFIG.symbolize_keys!

# # TODO:  create interface to update config options and persist to database.

# Config.load

file =  File.join(".", APP_CONFIG[:hotfolder])

if !Dir.exists? file
  puts "creating hotfolder at `#{file}`"
  FileUtils.mkdir_p file
end

puts "**** active hot folder:  '#{file}' ****"

# APP_CONFIG[:holdfolder] = file;

listener = Listen.to(file) do |modified, added, removed|
  if added.length > 0
    Rails.logger.info "call TeamResults"
    TeamResults.new.perform(added)
    Rails.logger.info "added file: #{added}"
  end
  if removed.length > 0
    Rails.logger.info "removed file : #{removed}"
  end
end
listener.start