# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :body
      t.integer :book_rate
      t.integer :status, default: 0
      t.belongs_to :user, foreign_key: true
      t.belongs_to :book, foreign_key: true

      t.timestamps
    end
  end
end
