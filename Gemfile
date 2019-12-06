# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.4"

gem "bootsnap", ">= 1.4.2", require: false
gem "dry-initializer"
gem "dry-validation"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.12"
gem "rails", "~> 6.0.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rubocop", require: false
  gem "ruby-progressbar", require: false
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "simplecov", require: false
end

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "faker", require: false
  gem "rspec-rails"
end
