
require Rails.root.join("config/initializers/user_config")
require Rails.root.join("config/initializers/markdown")

if Rails.env.development? or Rails.env.test?
  path = Rails.root.join("spec/fixtures")
else
  user_path = Rails.application.config.settings.posts
  user_path = user_path[1, user_path.length] if user_path.start_with?("/")
  path = Rails.root.join(user_path)
end

puts "Scanning blog posts in #{path}..."

scanner = BlogPostScanner.new(path)
scanner.scan_and_store
