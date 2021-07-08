class CategoriesController < ApplicationController

  # Authenticating user before performing any actions
  before_action :authenticate, except: %i[index show search]

  def index
    # Retrieving all categories
    @categories = Category.all
  end

  def show
    # Finding a record using its id
    @category = Category.find(params[:id])
  end

  def search
    # Finding the category by its name
    category = Category.find_by(name: params[:searchBooks].downcase)

    if category.nil?
      redirect_to books_path(none: 'true')
    else
      redirect_to(category_path(category))
    end
  end

  def new
    @category = Category.new
  end

  def create
    # Saving a category
    @category = Category.new(category_params)

    if @category.save
      redirect_to(categories_path)
    else
      render('new')
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    # Updating a category
    @category = Category.find(params[:id])

    if @category.update(category_params)
      redirect_to(categories_path)
    else
      render('edit')
    end
  end

  def delete
    @category = Category.find(params[:id])
  end

  def destroy
    # Deleting a category record
    @category = Category.find(params[:id])
    @category.destroy if @category.books.map(&:coverPic).map(&:purge) && @category.books.map(&:destroy)
    # Performing cleanup
    delete_empty_folders(categories_path)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
