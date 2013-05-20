
require Rails.root.join("lib/user_config_loader")
UserConfigLoader.load unless Rails.application.config.respond_to?(:settings)
