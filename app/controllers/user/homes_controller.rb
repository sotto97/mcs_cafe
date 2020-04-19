class User::HomesController < ApplicationController
  def top
  	@newses = News.page(params[:page])
  	@menus = Menu.all
  end

  def about
  end

  def news
  	@newses = News.all
  end
end
