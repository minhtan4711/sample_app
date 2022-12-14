# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "3.1.2"

gem "bcrypt", "3.1.13"
gem "bootstrap-sass", "3.4.1"
gem "active_storage_validations"
gem "image_processing", "1.12.2"
gem "mini_magick"
gem "config"
gem "figaro"
gem "faker", "2.22.0"
gem "jbuilder", "~> 2.7"
gem "mysql2", "~> 0.5"
gem "net-smtp", "~> 0.3.1"
gem "pagy"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.6"
gem "rails-i18n"
gem "sass-rails", ">= 6"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 5.0"

gem "bootsnap", ">= 1.4.4", require: false

group :development, :test do
  gem "pry-rails"
  gem "byebug", platforms: %i(mri mingw x64_mingw)
  gem "rubocop", "~> 1.26", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.14.0", require: false
end

group :development do
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver", ">= 4.0.0.rc1"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: %i(mingw mswin x64_mingw jruby)
