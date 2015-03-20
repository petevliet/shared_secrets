class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @comments = Comment.where(post_id:(params[:id]))
    @cid = params[:rep_cid]
  end

  def new
    @post = Post.new
    @cid = params[:rep_cid]
  end

  def create
    @post = Post.new(post_params)
    @post.cid = params[:rep_cid]
    @post.user = current_user
    @cid = params[:rep_cid]
    if @post.save
      flash[:notice] = "Post successfully created."
      redirect_to rep_path(params[:rep_cid])
    else
      render :new
    end
  end

  private
  def post_params
    params.require(:post).permit(:cid, :user_id, :link, :body)
  end
end
