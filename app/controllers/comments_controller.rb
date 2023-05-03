class CommentsController < ApplicationController
  before_action :set_params, only: [:update, :destroy]

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_path(params[:post_id])
    else
      redirect_to post_path(params[:post_id])
    end
  end

  def update
    @comment.update(comment_params)
    redirect_to post_path(params[:post_id])
  end

  def destroy
    @comment.destroy
    redirect_to post_path(params[:post_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, post_id: params[:post_id])
  end

  def set_params
    @comment = Comment.find_by(id: params[:id],post_id: params[:post_id])
  end
end
