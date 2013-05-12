
unless Rails.env.test?
  require Rails.root.join("config/initializers/markdown")

  if Rails.env.development?
    path = Rails.root.join("spec/fixtures")
  else
    path = Rails.root.join("posts")
  end

  puts "Scanning blog posts in #{path}..."

  scanner = BlogPostScanner.new(path)
  scanner.scan_and_store

end
