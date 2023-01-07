class BooksController < ApplicationController
  before_action :correct_user, only:[:edit]

  # 一覧
  def index
    @books = Book.all
  end

  # 詳細
  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @user = @book.user
  end

  # 編集
  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  # 登録
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user = @book.user
      render :index
    end

  end

  # 削除
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end
