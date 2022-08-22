# frozen_string_literal: true

class HomePagesController < ApplicationController
  def home
    @latest_books = Book.order(created_at: :desc).limit(3).decorate
  end
end
