require 'yaml'

class BlogPost
  attr_accessor :body, :title

  def self.from_file(path)
    all = File.read(path).strip
    meta, content = split_meta_and_content(all)
    meta = parse_meta(meta, path)

    post = BlogPost.new
    post.body = render_body(content)
    post.title = meta[:title]

    return post
  end

  private

  def self.render_body(body)
    body
  end

  def self.parse_meta(raw_meta, path)
    # initial defaults
    meta = { }
    YAML.load(raw_meta).each { |k,v| meta[k.downcase.to_sym] = v } unless raw_meta.empty?
    meta
  end

  def self.split_meta_and_content(all)
    end_of_meta = all.index("*/")
    if end_of_meta
      meta = all[2, end_of_meta - 2].strip
      content = all[end_of_meta + 2, all.length].strip
      return [meta, content]
    else
      return ["", all]
    end
  end
end
