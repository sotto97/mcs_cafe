class User::HomesController < ApplicationController
  def top
  	@newses = News.all
  end

  def about
  end
end
