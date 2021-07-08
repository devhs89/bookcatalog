class Category < ApplicationRecord
  # A many-to-many relationship between "books" and a "category" through "book_categories" model
  has_many :book_categories
  has_many :books, through: :book_categories

  # A regex pattern for category name validation
  NAMING_PATTERN = /\A\w{,30}\z/
  validates :name, presence: true, format: { with: NAMING_PATTERN }

  # storing records in lowercase form
  before_save { name.downcase! }
end
