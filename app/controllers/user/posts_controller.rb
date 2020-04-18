class User::PostsController < ApplicationController
  def index
  	@user = User.find(current_user.id)
  	# @posts = Post.all.order(created_at: :desc)
    @posts = Post.order(created_at: :desc).page(params[:page])
  end

  def show
   	@user = User.find(current_user.id)
  	@post = Post.find(params[:id])
    @post_comments = @post.post_comments
    @post_comment = PostComment.new
  end

  def create
  	@posts = Post.all
  	@post = Post.new(post_params)
  	@post.user_id = current_user.id
  	if @post.save
  		redirect_to user_path(current_user.id)
    else
      render "show"
  	end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.permit(:body, :image)
  end

end
