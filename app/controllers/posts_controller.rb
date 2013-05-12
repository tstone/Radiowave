
class PostsController < ApplicationController

  def index
    @posts = BlogPost.all
  end

  def show
    id = params[:id]
    @post = BlogPost.find(id)
    @next_post = BlogPost.next(id)
    @prev_post = BlogPost.prev(id)
  end

end
