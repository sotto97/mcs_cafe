class User::SearchesController < ApplicationController
  def search
  	@user = current_user
  	# usernameで検索可能
    if params[:username].present?
      @users = User.where('username LIKE ?', "%#{params[:username]}%")
    else
      @users = User.none
    end
  end
end
