class Admin::MenusController < ApplicationController
  def index
  	@menus = Menu.all
  	@menu = Menu.new
  end

  def create
  	@menus = Menu.all
  	@menu = Menu.new(menu_params)
		if @menu.save
			redirect_to admin_menus_path
		end
  end

  def update
  	@menu = Menu.find(params[:id])
  	if @menu.update(menu_params)
  		redirect_to admin_menus_path
  	end
  end

  # destroyはactionのみ
  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy
    redirect_to admin_menus_path
  end

  private

  def menu_params
    params.require(:menu).permit(:menu_image)
  end
end
