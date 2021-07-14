class BooksController < ApplicationController
  before_action :authenticate_user!

  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
       redirect_to book_path(@book.id), notice:'You have created book successfully.'
    else
       @user=current_user
       @books=Book.all
       render :index
    end
  end

  def index
    @user=current_user
    @book=Book.new # 新規投稿
    @books=Book.all
  end

  def show
    @book_new=Book.new  # 投稿詳細ページから新規投稿した際のインスタンス変数
    @book=Book.find(params[:id])
    @user=@book.user   # Userinfo @user
  end

  def edit
    @book=Book.new
    @book=Book.find(params[:id])
    if @book.user== current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
       redirect_to book_path(@book.id), notice:'You have updated book successfully.'
    else
        render :edit
    end
  end

  def destroy
    @book=Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book=Book.find(params[:id])
  return if @book.user == current_user
    redirect_to books_path
  end
end