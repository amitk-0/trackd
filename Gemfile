source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.4"
gem "rails", "~> 7.0.4", ">= 7.0.4.2"
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "puma", "~> 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "bcrypt"
gem "redis", "~> 4.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "importmap-rails"
gem "hotwire-rails", "~> 0.1.3"
gem "bootsnap", require: false
gem "sassc-rails"
gem "jquery-rails"
gem "paper_trail"
gem "acts_as_paranoid"
gem "rails-controller-testing"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'annotate'
  gem 'byebug'
  gem 'minitest'
  gem 'brakeman'
  gem 'faker'
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

