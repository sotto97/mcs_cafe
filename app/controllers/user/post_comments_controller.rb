class User::PostCommentsController < ApplicationController
  def create
  	@post = Post.find(params[:post_id])
  	@post_comment = PostComment.new(post_comment_params)
  	@post_comment.user_id = current_user.id
  	@post_comment.save
  	redirect_to post_path(@post)
  end

  def destroy
  end

  private

  def post_comment_params
  	params.require(:post_comment).permit(:comment)
  end

end