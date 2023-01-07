class UsersController < ApplicationController
  before_action :correct_user, only:[:edit]
  
  # 一覧
  def index
    @users = User.all
  end

  # 詳細
  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  # 編集
  def edit
    @user = User.find(params[:id])
  end

  def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:notice] ="You have updated user successfully."
        redirect_to user_path(@user.id)
      else
        render :edit
      end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(user_path(current_user)) unless @user == current_user
  end
end
