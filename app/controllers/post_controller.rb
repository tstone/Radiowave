
class PostController < ApplicationController

  def index
    @posts = BlogPost.all
  end

end
