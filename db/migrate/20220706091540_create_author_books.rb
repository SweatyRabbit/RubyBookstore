# frozen_string_literal: true

class CreateAuthorBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :author_books, &:timestamps
  end
end
