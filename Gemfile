source "https://rubygems.org"

ruby "3.0.6"

gem "rails", "~> 7.1.3", ">= 7.1.3.2"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem 'actionmailer'
# gem "redis", ">= 4.0.1"
# gem "kredis"
# gem "bcrypt", "~> 3.1.7"
gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]
gem "bootsnap", require: false
gem "image_processing", "~> 1.2"
gem "devise"
gem 'cancancan', '~> 3.1'
gem "tailwindcss-rails", "~> 2.6"
# gem 'mini_magick'
gem "foreman"

group :development, :test do
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ]
  gem 'rspec-rails', '~> 3.4', '>= 3.4.2'
  gem "letter_opener"
end

group :development do
  gem "web-console"
  # gem "rack-mini-profiler"
  gem "spring"
  gem "dotenv-rails"
  gem "better_errors"
  gem "binding_of_caller"
  gem 'pry-rails'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
