
unless Rails.application.config.respond_to?(:settings)
  config_path = Rails.root.join("config/settings.yml")
  raw_yml = File.read(config_path)
  raw_config = YAML.load(raw_yml)
  raw_config.reverse_merge!({
    host: "http://localhost:3000",
    posts: "/posts",
    count: 12,
    title: "MicrowaveJS Blog",
    desc:  "An example MicrowaveJS blog that you'll want to read again and again!",
    author: "Blog Author",
    forcehost: true,
    posttimeformat: "MMMM d, yyyy",
    comments: true,
    disqusname: "testblog",
    sharing: true,
    twittersharing: true,
    twittername:  "twittername",
    facebooksharing: false,
    googlesharing: false,
    hackernewssharing: true,
    theme: "default"
  })

  Rails.application.config.settings = OpenStruct.new(raw_config.to_h)

  # re-write views path based on theme
  ActionController::Base.class_eval do
    self.view_paths = ActionView::PathSet.new([
      "lib/themes/#{Rails.application.config.settings.theme}/views",
      "lib/themes/default/views"
    ].uniq)
  end

  # re-write assets path based on theme
  Rails.application.config.assets.paths = []
  theme = Rails.application.config.settings.theme
  root = Rails.root

  # default theme assets
  if !theme or theme != "default"
    Rails.application.config.assets.paths.unshift "#{root}/lib/themes/default/assets/fonts"
    Rails.application.config.assets.paths.unshift "#{root}/lib/themes/default/assets/images"
    Rails.application.config.assets.paths.unshift "#{root}/lib/themes/default/assets/stylesheets"
    Rails.application.config.assets.paths.unshift "#{root}/lib/themes/default/assets/javascripts"
  end

  # configured theme assets
  if theme
    Rails.application.config.assets.paths.unshift "#{root}/lib/themes/#{theme}/assets/fonts"
    Rails.application.config.assets.paths.unshift "#{root}/lib/themes/#{theme}/assets/images"
    Rails.application.config.assets.paths.unshift "#{root}/lib/themes/#{theme}/assets/stylesheets"
    Rails.application.config.assets.paths.unshift "#{root}/lib/themes/#{theme}/assets/javascripts"
  end
end
