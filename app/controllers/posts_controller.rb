class PostsController < ApplicationController

  def new
    @post = Post.new
    @cid = params[:rep_cid]
  end

  def create
    @post = Post.new(post_params)
    @post.cid = params[:rep_cid]
    @post.user_id = session[:user_id]
    if @post.save
      flash[:notice] = "post successfully created"
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
