
require Rails.root.join("config/initializers/user_config")
require Rails.root.join("config/initializers/markdown")

if Rails.env.development? or Rails.env.test?
  path = Rails.root.join("spec/fixtures")
else
  path = Rails.root.join("posts")
end

puts "Scanning blog posts in #{path}..."

scanner = BlogPostScanner.new(path)
scanner.scan_and_store
