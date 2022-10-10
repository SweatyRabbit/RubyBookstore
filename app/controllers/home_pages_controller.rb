# frozen_string_literal: true

class HomePagesController < ApplicationController
  LIMIT_BOOKS_TO_SHOW = 3
  BESTSELLERS_LIMIT = 4

  def home
    @latest_books = Book.order(created_at: :desc).limit(LIMIT_BOOKS_TO_SHOW).decorate
    @bestsellers = bestsellers.first(BESTSELLERS_LIMIT)
  end

  private

  def bestsellers
    Books::BestsellersQuery.new.call.decorate
  end
end
