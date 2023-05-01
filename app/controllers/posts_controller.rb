class PostsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :set_params, only: [:show, :edit, :update, :destroy, :download]
  before_action :compare_id, only: [:edit]

  def index
    @post = Post.order("created_at DESC")
    @room = Room.new
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    if user_signed_in?
      @post.destroy
      redirect_to action: :index
    else
      redirect_to action: :show
    end
  end

  def download
    begin
      data = @post.image.download
      content_type = ''
      filename = ''
      # 画像の形式に応じてMIMEタイプとファイル名を指定する
      if @post.image.content_type == 'image/png'
        content_type = 'image/png'
        filename = 'download.png'
      elsif @post.image.content_type == 'image/jpeg'
        content_type = 'image/jpeg'
        filename = 'download.jpeg'
      elsif @post.image.content_type == 'image/jpg'
        content_type = 'image/jpeg'
        filename = 'download.jpg'
      end
      # 画像を送信する
      send_data(data, type: content_type, filename: filename)
    rescue
      flash[:alert] = '画像のダウンロードに失敗しました'
    end
  end


  private
  
  def post_params
    params.require(:post).permit(:title, :content, :category_id, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def set_params
    @post = Post.find(params[:id])
  end

  def compare_id
    if current_user.id != @post.user_id
      redirect_to root_path 
    end
  end
end
