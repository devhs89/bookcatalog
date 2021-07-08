class BookCategory < ApplicationRecord
  # A many-to-one relationship between "books" and "book_category" & "category" and "book_category" model
  belongs_to :book
  belongs_to :category
end
