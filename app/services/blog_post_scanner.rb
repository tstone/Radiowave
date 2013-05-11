
class BlogPostScanner

  def initialize(posts_path)
    @posts_path = posts_path
  end

  def scan(&block)
    Dir[@posts_path + "/*.md"].map do |post_path|
      block.call(post_path) if block_given?
    end
  end

  def scan_and_parse
    scan do |post_path|
      BlogPost.new
    end
  end

end
