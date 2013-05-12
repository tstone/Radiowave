
class BlogPostScanner

  def initialize(posts_path)
    @posts_path = posts_path
  end

  def scan(&block)
    scan_path = File.join(@posts_path, "**/*.*")
    Dir[scan_path].map do |post_path|
      block.call(post_path) if block_given?
    end
  end

  def scan_and_parse
    posts = scan do |post_path|
      BlogPost.from_file(post_path)
    end
    return posts.sort { |a,b| b.date <=> a.date }
  end

  def scan_and_store
    posts = scan_and_parse
    BlogPost.class.send(:include, MemoryStore)
    BlogPost.initialize_store(posts)
    posts
  end

end
