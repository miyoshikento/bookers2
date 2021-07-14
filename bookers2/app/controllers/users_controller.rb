class UsersController < ApplicationController
  def index
    @user=current_user  # @user誰がログインしているのか、idつけるとエラー
    @users=User.all
    @book=Book.new
    @books=Book.all
  end
  
  def show
    @user=User.find(params[:id])
    @book=Book.new
    @books=Book.where(user_id: @user.id) # user_idカラムに@user.idで投稿された全レコードを取得
  end
  
  def edit
    @user=User.find(params[:id])
    if @user == current_user
      render :edit # 現在ログインしている人だったらedit
    else
      redirect_to user_path(current_user) # そうでなければ現在ログインしている人のusersの詳細画面へ
    end
  end
  
  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_path(current_user), notice:'You have updated user successfully.'
    else
       render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
end
