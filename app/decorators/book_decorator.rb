class BookDecorator < ApplicationDecorator
  delegate_all

  def authors_full_name
    authors.map { |author| "#{author.first_name} #{author.last_name}" }.join(', ')
  end
end
