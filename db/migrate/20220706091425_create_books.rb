# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.decimal :price
      t.text :description
      t.integer :publication_year
      t.decimal :height, precision: 10, scale: 2
      t.decimal :width, precision: 10, scale: 2
      t.decimal :depth, precision: 10, scale: 2
      t.string :materials
      t.belongs_to :category

      t.timestamps
    end
  end
end
