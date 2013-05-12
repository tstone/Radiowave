
class PostsController < ApplicationController

  def index
    @posts = BlogPost.all
  end

end
