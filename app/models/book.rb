class Book < ApplicationRecord
  # A one-to-one relation with "ActiveStorage" models
  has_one_attached :coverPic
  # A many-to-one & "has_many :through" relation with book_categories & categories
  has_many :book_categories, dependent: :destroy
  has_many :categories, through: :book_categories

  # A regex pattern to validate names
  NAMES_REGEX = /\A[A-Za-z]+([\sA-Za-z]+)*\z/
  validates :title, presence: true, format: { with: NAMES_REGEX }
  validates :author, presence: true, format: { with: NAMES_REGEX }
  validates :publish_date, presence: true
  validates :description, presence: true
  validates :content, presence: true

  # Applying lowercase and changing filenames before saving
  before_save :col_downcase, :set_filename

  def col_downcase
    title.downcase!
    author.downcase!
  end

  def set_filename
    if coverPic.attached?
      ext = ".#{coverPic.blob.filename.extension}"
      coverPic.blob.update(filename: "#{title}#{ext}")
    end
  end
end
