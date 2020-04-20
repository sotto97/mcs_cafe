class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
  def search
  	# user.idで検索可能
    if params[:id].present?
      @users = User.where('id LIKE ?', "%#{params[:id]}%")
    else
      @users = User.none
    end
  end
end
