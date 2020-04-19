class User::SearchesController < ApplicationController
  before_action :authenticate_user!
  def search
  	@user = current_user
  	# usernameでのみ検索可能
    if params[:username].present?
      @users = User.where('username LIKE ?', "%#{params[:username]}%")
    else
      @users = User.none
    end
  end
end
