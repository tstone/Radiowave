
class UserConfigLoader

  class << self

    def asset_paths
      %w( javascripts stylesheets images fonts )
    end

    def default_settings
      {
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
      }
    end

    def load
      raw_config = read_settings_yml
      raw_config.reverse_merge!(default_settings)
      Rails.application.config.settings = OpenStruct.new(raw_config.to_h)
      rewrite_view_path
      rewrite_asset_paths
    end

    def theme
      Rails.application.config.settings.theme
    end

    def read_settings_yml
      config_path = Rails.root.join("config/settings.yml")
      raw_yml = File.read(config_path)
      YAML.load(raw_yml)
    end

    def rewrite_view_path
      ActionController::Base.class_eval do
        paths = [
          "themes/#{Rails.application.config.settings.theme}/views",
          "themes/default/views"
        ].select { |p| Dir.exists?(Rails.root.join(p)) }
        self.view_paths = ActionView::PathSet.new(paths.uniq)
      end
    end

    def rewrite_asset_paths
      paths = []
      asset_paths.each { |p| add_asset_path(paths, p, theme) } if theme
      asset_paths.each { |p| add_asset_path(paths, p, "default") } if !theme or theme != "default"
      paths = paths.uniq
      Rails.application.config.assets.paths = paths.concat(Rails.application.config.assets.paths)
    end

    def add_asset_path(paths, p, theme)
      path = Rails.root.join("themes", theme, "assets", p)
      if Dir.exists?(path)
        paths << path
      end
    end
  end
end
