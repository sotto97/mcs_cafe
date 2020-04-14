class Admin::NewsController < ApplicationController
  def index
  	@newses = News.all
   	@news_new = News.new
  end

  def show
  end

  def confirm
  	@newses = News.all
   	@news_new = News.new(news_params)
		@news_new.admin_id = current_admin.id
		if @news_new.valid?
			render :confirm
		else
	    render :index
		end
  end

  def back #viewで"入力画面に戻る"を押した時に使うaction
    render :index
  end

  def create
  	@news_new = News.new(news_params)
    if params[:back]
      render :index
		else
			@news_new.save
			redirect_to admin_news_index_path
		end
  end

  private

  def news_params
    params.require(:news).permit(:title, :body, :admin_id)
  end
end
