class BooksController < ApplicationController

  # Authenticating user before performing any actions
  before_action :authenticate, except: %i[index show_all show]

  def index
    # Retrieving books and limiting the number to top 3
    @recent_books = Book.order('publish_date DESC').limit(3)
    @categories = Category.all
  end

  def show_all
    # Retrieving all books
    @books = Book.all
  end

  def show
    # Finding a record using its id
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    # Creating a book
    category = Category.find_by(name: params[:book][:category].downcase)

    if category
      @book = Book.new(book_params)
      if @book.save
        @book.book_categories.create(category: category) && redirect_to(books_path)
      else
        render('new')
      end
    else
      render('new')
    end
  end

  def edit
    @book = Book.find(params[:id])
    @category = @book.categories.map(&:name)
  end

  def update
    # Updating a book
    @book = Book.find(params[:id])

    if @book.update(book_params)
      redirect_to(book_path)
    else
      render('edit')
    end
  end

  def delete
    @book = Book.find(params[:id])
  end

  def destroy
    # Deleting a book
    @book = Book.find(params[:id])

    if @book.coverPic.attached?
      @book.coverPic.purge
    end

    @book.destroy
    delete_empty_folders(show_all_books_path)
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :coverPic, :publish_date, :description, :content)
  end
end