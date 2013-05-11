
class BlogPost
  attr_accessor :body, :path, :tags

  def initialize(&block)
    block.call(self) if block_given?
  end

  def comments
    @comments
  end

  def date
    @date
    #  File.ctime(@path)
  end

  def slug
    @slug
  end

  def title
    @title
  end

  def set_attributes(values)
    values.each do |k,v|
      instance_variable_set("@#{k}".to_sym, v)
    end
    return self
  end

  # --- class methods ----------------------------------------------------------

  def self.from_file(path)
    all = File.read(path).strip
    meta, content = split_meta_and_content(all)

    BlogPost.new do |post|
      post.path = path
      post.body = render_body(content)
      post.set_attributes(parse_meta(meta, path))
    end
  end

  private # --------------------------------------------------------------------

  def self.render_body(body)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                       :autolink => true,
                                       :space_after_headers => true)
    markdown.render(body)
  end

  def self.parse_meta(raw_meta, path)
    meta = { }
    YAML.load(raw_meta).each { |k,v| meta[k.downcase.to_sym] = v } unless raw_meta.empty?

    # parse date
    meta[:date] = Date.parse(meta[:date]) if meta[:date]

    # parse and format comments
    if meta[:tags]
      meta[:tags] = meta[:tags].split(",") unless meta[:tags].is_a? Array
      meta[:tags] = meta[:tags].map { |tag| tag.strip.downcase }
    end

    return meta
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
