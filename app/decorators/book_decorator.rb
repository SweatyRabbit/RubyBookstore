class BookDecorator < ApplicationDecorator
  delegate_all
  decorates_association :authors

  def authors_full_name
    object.authors.map { |author| "#{author.first_name} #{author.last_name}" }.join(', ')
  end
end
