class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout -> { themed_layout_path }

  def themed_view_path(view)
    controller = self.controller_name == "application" ? "" : self.controller_name
    themed_path("views/#{controller}", view, ".html.slim")
  end

  def themed_layout_path
    themed_path("views/layouts", "application", ".html.slim")
  end

  def themed_path(root, file, default_extension)
    theme = Rails.application.config.settings.theme

    if theme and theme != "default"
      # search for a globbed match and return it if found
      partial_file_matches = Dir.glob(Rails.root.join("lib", "themes", theme, root, file + ".*"))
      unless partial_file_matches.empty?
        return chomp_theme_path(partial_file_matches.first)
      end
    end

    # return default otherwise
    default_view_path = Rails.root.join("lib", "themes", "default", root, file + default_extension).to_s
    return chomp_theme_path(default_view_path)
  end

  private

  def chomp_theme_path(path)
    path.to_s.gsub(Rails.root.to_s, "")
  end
end
