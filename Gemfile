# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

gem 'bootsnap', require: false
gem 'bootstrap-sass', '~> 3.4.1'
gem 'devise', '~> 4.8.1'
gem 'haml-rails'
gem 'importmap-rails'
gem 'jbuilder'
gem 'jquery-rails', '~> 4.5.0'
gem 'omniauth-facebook', '~> 9.0'
gem 'omniauth-rails_csrf_protection', '~> 1.0.1'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.3'
gem 'sassc-rails', '>= 2.1.0'
gem 'simple_form', '~> 5.1'
gem 'sprockets-rails', require: 'sprockets/railtie'
gem 'stimulus-rails'
gem 'turbolinks'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'pagy', '~> 3.5'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'draper'
  gem 'factory_bot_rails'
  gem 'fasterer', '~> 0.9', require: false
  gem 'ffaker'
  gem 'lefthook', '~> 0.5.5'
  gem 'pry'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '>= 3.9.0'
end

group :development do
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 5.1.0'
  gem 'simplecov'
  gem 'webdrivers'
end
