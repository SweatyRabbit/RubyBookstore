# frozen_string_literal: true

class BooksController < ApplicationController
  include Pagy::Backend
  BOOKS_TO_SHOW = 12

  def index
    @pagy, @books = pagy_countless(prepared_books, link_extra: 'data-remote="true', items: BOOKS_TO_SHOW)
  end

  private

  def prepared_books
    FilterBooksByCategory.new(params).call
  end
end
