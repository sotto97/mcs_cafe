class User::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :baria_user, only: [:edit, :update, :hide]

  def index
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page])
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
    @user = User.find(current_user.id)
    #is_deletedカラムにフラグを立てる(defaultはfalse)
    @user.update(is_deleted: true)
    #ログアウトさせる
    reset_session
    redirect_to root_path
  end

  def following
    #@userがフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.following
  end

  def followers
    #@userをフォローしているユーザー
    @user  = User.find(params[:id])
    @users = @user.followers
  end

  def notice
  end

  def create
  end

  private

  def user_params
    params.require(:user).permit(:email ,:first_name, :last_name, :first_name_kana, :last_name_kana, :username, :profile_image, :address, :introduction, :age, :job)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
  def baria_user
    unless params[:id].to_i == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
