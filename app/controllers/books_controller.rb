class BooksController < ApplicationController

before_action :correct_user, only: [:edit, :update]

  def new
    @book = Book.new
  end

  def create
    @user = current_user
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.new
    @book_sub = Book.find(params[:id])
    @user = @book_sub.user
  end

  def edit
    @book_sub = Book.find(params[:id])
  end


  def update
    @book_sub = Book.find(params[:id])
    if @book_sub.update(book_params)
      redirect_to book_path(@book_sub.id), notice: "You have updated book successfully."
    else
      @books = Book.all
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

  def correct_user
    @book_sub = Book.find(params[:id])
    @user = @book_sub.user
    redirect_to(books_path) unless @user == current_user
  end

end
