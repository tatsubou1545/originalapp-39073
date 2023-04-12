class PostsController < ApplicationController

  def index
    @post = Post.all
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = Item.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :category_id, :image).merge(user_id: current_user.id)
  end

end
