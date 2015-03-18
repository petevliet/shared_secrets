class CommentsController < ApplicationController

  def new
    @post = Post.find(params[:post_id])
    @cid = params[:rep_cid]
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post = Post.find(params[:post_id])
    @comment.user_id = session[:user_id]
    if @comment.save
      flash[:notice] = "comment successfully created"
      redirect_to rep_path(params[:rep_cid])
    else
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :post_id, :user_id)
  end

end
