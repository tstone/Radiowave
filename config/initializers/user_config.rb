
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
    hackernewssharing: true
  })

  Rails.application.config.settings = OpenStruct.new(raw_config.to_h)
end
