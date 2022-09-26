# frozen_string_literal: true

class BooksController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @books = pagy_countless(prepared_books, link_extra: 'data-remote="true"')
    @books_count = Book.all.count
  end

  def show
    @book = Book.find(params[:id])
  end

  private

  def prepared_books
    FilterBooksByCategory.new(params).call
  end
end
