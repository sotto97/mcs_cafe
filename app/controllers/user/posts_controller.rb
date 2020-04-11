class User::PostsController < ApplicationController
  def index
  	@user = User.find(current_user.id)
  	@posts = Post.all
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
  	end
  end

  def destroy
  end

  private

  def post_params
    params.permit(:body)
  end

end
