
class BlogPostScanner

  def initialize(posts_path, post_store=nil)
    # todo: post stores
    @posts_path = posts_path
  end

  def scan_and_parse
    Dir[@posts_path + "/*"].map do |post_path|
      BlogPost.new
    end
  end

end
