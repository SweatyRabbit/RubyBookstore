# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'bootsnap', require: false
gem 'bootstrap-sass', '~> 3.4.1'
gem 'countries', '~> 3.1'
gem 'devise', '~> 4.8.1'
gem 'draper'
gem 'factory_bot_rails'
gem 'ffaker'
gem 'haml-rails'
gem 'importmap-rails'
gem 'jbuilder'
gem 'jquery-rails', '~> 4.5.0'
gem 'omniauth-facebook', '~> 9.0'
gem 'omniauth-rails_csrf_protection', '~> 1.0.1'
gem 'pagy', '~> 3.5'
gem 'pg', '~> 1.1'
gem 'pry', '~> 0.14.0'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.3'
gem 'sassc-rails', '>= 2.1.0'
gem 'simplecov', '~> 0.21.2', require: false
gem 'simple_form', '~> 5.1'
gem 'sprockets-rails', require: 'sprockets/railtie'
gem 'stimulus-rails'
gem 'turbolinks'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'capybara', '~> 3.35.3'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'fasterer', '~> 0.9', require: false
  gem 'lefthook', '~> 0.5.5'
  gem 'rspec-rails', '>= 3.9.0'
end

group :development do
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'database_cleaner', '~> 2.0.1'
  gem 'rack_session_access', '~> 0.2.0'
  gem 'rack-test', '~> 1.1'
  gem 'rails-controller-testing', '~> 1.0.5'
  gem 'selenium-webdriver', '~> 4.1.0'
  gem 'shoulda-matchers', '~> 5.1.0'
  gem 'webdrivers'
end
