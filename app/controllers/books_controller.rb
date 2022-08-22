# frozen_string_literal: true

class BooksController < ApplicationController
  include Pagy::Backend

  DATA_REMOTE = 'data-remote="true"'

  def index
    @pagy, @books = pagy_countless(prepared_books, link_extra: DATA_REMOTE)
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
