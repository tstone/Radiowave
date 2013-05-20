require 'fileutils'

module ThemeManagement

  def test_theme_name
    "test_theme"
  end

  def theme_path
    Rails.root.join("lib", "themes", test_theme_name)
  end

  def teardown_test_theme
    FileUtils.rm_rf(theme_path) if Dir.exist?(theme_path)
  end

  def write_theme_file(p, content)
    path = theme_path.join(p)

    # recursivley create dirs as needed
    dir = File.dirname(path)
    FileUtils.mkpath(dir) unless Dir.exists?(dir)

    File.open(path, "w+") { |f| f.write(content) }
  end

end
