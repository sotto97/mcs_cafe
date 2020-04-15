class User::HomesController < ApplicationController
  def top
  	@newses = News.all
  	@menus = Menu.all
  end

  def about
  end
end
