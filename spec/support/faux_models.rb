
module FauxModels

  def faux_blog_post(options={})
    BlogPost.new do |bp|
      bp.title = "Test Blog Post"
      bp.set_attributes(options)
    end
  end

end
