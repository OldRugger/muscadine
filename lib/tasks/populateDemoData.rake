
namespace :demo_data do
  desc "load demo data"
  task load: :environment do
    puts "load demo data"
    Runner.import(File.new("spec/fixtures/OE0010_import_test_data.csv"))
    puts "#{Runner.count} runners loaded"
    Team.import(File.new("spec/fixtures/teams.csv"))
    puts "#{Team.count} teams loaded"
    source = "spec/fixtures/files/OE0013_two_day_results.csv"
    target = File.join(".", "tmp/OE0013_two_day_results.csv")
    FileUtils.cp(source, target)
    TeamResults.new.perform([target])
  end
end
