class CreateAuthorBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :author_books do |t|

      t.timestamps
    end
  end
end
