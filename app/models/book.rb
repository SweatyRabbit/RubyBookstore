class Book < ApplicationRecord
  validates :title, :price, precence: true
  validates :price, numericality: { greater_than: 0.0 }

  has_many :authors, through: :author_books
end
