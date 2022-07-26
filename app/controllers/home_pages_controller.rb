# frozen_string_literal: true

class HomePagesController < ApplicationController
  def home
    @books = Book.order(created_at: :desc).limit(2).decorate
  end
end
