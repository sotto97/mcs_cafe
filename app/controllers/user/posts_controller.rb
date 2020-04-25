class User::PostsController < ApplicationController
  before_action :authenticate_user!
  def index
  	@user = User.find(current_user.id)
    @posts = Post.order(created_at: :desc).page(params[:page])
    @skills = Skill.all
  end

  def show
   	@user = User.find(current_user.id)
  	@post = Post.find(params[:id])
    @post_comments = @post.post_comments
    @post_comment = PostComment.new
    @skills = Skill.all
  end

  def create
  	@posts = Post.all
  	@post = Post.new(post_params)
  	@post.user_id = current_user.id
  	if @post.save
    else
      render "show"
  	end
  end

  def destroy
    @posts = Post.all
    @post = Post.find(params[:id])
    @post.destroy
  end

  private

  def post_params
    params.permit(:body, :image)
  end

end
