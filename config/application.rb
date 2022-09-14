# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module RubyBookstore
  class Application < Rails::Application
    config.load_defaults 7.0
  end
end
