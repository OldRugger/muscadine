require 'fileutils'

Config.load

file =  File.join(".", Config.last.hotfolder)

if !Dir.exists? file
  puts "creating hotfolder at `#{file}`"
  FileUtils.mkdir_p file
end

puts "**** active hot folder:  '#{file}' ****"

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