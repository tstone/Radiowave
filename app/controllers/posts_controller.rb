
class PostsController < ApplicationController

  def index
    page = params[:page].to_i
    page = 1 unless page > 0
    page_size = Rails.application.config.settings.count or 12
    offset = (page - 1) * page_size

    @posts = BlogPost.page(offset, page_size)
  end

  def show
    id = params[:id]
    @post = BlogPost.find(id)
    @next_post = BlogPost.next(id)
    @prev_post = BlogPost.prev(id)
  end

end
