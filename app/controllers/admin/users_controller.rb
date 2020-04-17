class Admin::UsersController < ApplicationController
  def index
  	@users = User.order(created_at: :asc).page(params[:page])
  	# @user = User.find(params[:id])
  end

  def show
  	@user = User.find(params[:id])
  end

  def relationship
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to admin_users_path
  	end
  end

  private

  def user_params
    params.require(:user).permit(:is_deleted)
  end
end
