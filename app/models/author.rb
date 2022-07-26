# frozen_string_literal: true

class Author < ApplicationRecord
  validates :first_name, :last_name, presence: true

  has_many :author_books
  has_many :books, through: :author_books
end
