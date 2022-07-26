# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.decimal :price
      t.text :description
      t.belongs_to :category

      t.timestamps
    end
  end
end
