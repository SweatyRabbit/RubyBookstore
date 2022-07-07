# frozen_string_literal: true

class Book < ApplicationRecord
  validates :title, :price, presence: true
  validates :price, numericality: { greater_than: 0.0 }

  has_many :authors, through: :author_books
end
