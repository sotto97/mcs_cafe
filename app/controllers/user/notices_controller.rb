class User::NoticesController < ApplicationController
  before_action :authenticate_user!
  def new
    @user  = User.find(params[:user_id])
  end

  def create
    @notice = Notice.new(notice_params)
    @user  = User.find(params[:user_id])
    @notice.user_id = @user.id
    if @notice.save
      redirect_to user_path(@user.id)
    else
    	render "new"
    end
  end
  private
  def notice_params
    params.permit(:user_id, :username, :body)
  end
end
