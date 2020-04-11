class User::UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def hide
  end

  def notice
  end

  def create
  end

  private

  def user_params
    params.require(:user).permit(:email ,:first_name, :last_name, :first_name_kana, :last_name_kana, :username, :profile_image_id, :address, :introduction, :age, :job)
  end
end
