# frozen_string_literal: true

FactoryBot.create_list(:category, 4).each do |category|
  FactoryBot.create_list(:book, 12, :with_authors, category: category)
end
