require File.expand_path('../boot', __FILE__)
require "action_controller/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

Bundler.require(:default, Rails.env)

module Radiowave
  class Application < Rails::Application

    config.autoload_paths << "#{config.root}/app/services"

    config.middleware.delete "Rack::Lock"
    config.middleware.delete "ActionDispatch::Flash"
    config.middleware.delete "ActionDispatch::BestStandardsSupport"

  end
end
