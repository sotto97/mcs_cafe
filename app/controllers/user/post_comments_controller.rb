class User::PostCommentsController < ApplicationController
  def create
  	@post = Post.find(params[:post_id])
    @post_comment = @post.post_comments.new(post_comment_params)
    # @post_comment.post_id = @post.id　# この記述が無いとcommentとpostが紐づけられない
  	@post_comment.user_id = current_user.id
  	@post_comment.save
  	redirect_to post_path(@post)
  end

  def destroy
    @post_comment = PostComment.find(params[:post_id])
    @post = @post_comment.post
    if @post_comment.user != current_user
      redirect_to request.referer
    end
    @post_comment.destroy
    redirect_to post_path(@post)
  end

  private

  def post_comment_params
  	params.require(:post_comment).permit(:comment)
  end

end