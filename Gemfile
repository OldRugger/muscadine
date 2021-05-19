source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'
gem 'rails', '~> 6.0.0'
gem 'sqlite3', '~> 1.4'
gem 'puma', '~> 4.3'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'listen', '>= 3.0.5', '< 3.2'
gem 'sucker_punch'
gem 'rack-cors'
# gem "roo", "~> 2.8.0"
# Note: PR submitted to fix bug
gem "roo", git: "https://github.com/OldRugger/roo", branch: "issue-310_off_by_one"
gem 'active_model_serializers'

group :development, :test do
  gem 'rspec-rails'
   # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'database_cleaner'
  gem 'simplecov', :require => false
  gem 'rspec-json_expectations'
end

group :development do
  gem 'rack-mini-profiler'
  gem 'rubycritic', require: false
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
