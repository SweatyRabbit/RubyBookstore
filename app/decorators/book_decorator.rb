# frozen_string_literal: true

class BookDecorator < ApplicationDecorator
  delegate_all

  def authors_full_name
    authors.map { |author| "#{author.first_name} #{author.last_name}" }.join(', ')
  end

  def resize_title_image(size)
    title_image.variant(resize_to_limit: [size, size])
  end

  def resized_body_images(size)
    body_images.each { |image| image.variant(resize_to_limit: [size, size]) }
  end
end
