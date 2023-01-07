source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.3"
gem "rails", "~> 7.0.4"
gem "sqlite3", "~> 1.4"
gem "puma", "~> 5.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

gem 'devise_token_auth'
gem 'rack-cors'
# Rendering
gem 'jbuilder'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'faker'
end

group :development do
end

