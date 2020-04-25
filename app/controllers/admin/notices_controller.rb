class Admin::NoticesController < ApplicationController
  before_action :authenticate_admin!
  def index
  	@notices = Notice.all.order(created_at: :desc).page(params[:page])
  end

  def show
  	@notice = Notice.find(params[:id])
  end
end
