# frozen_string_literal: true

RSpec.describe 'Index', type: :feature do
  let!(:books) { create_list(:book, 5) }
  let!(:admin) { create(:admin_user) }
  let(:book_attributes) { %i[title price authors_full_name] }

  before do
    visit '/admin'
    fill_in('admin_user_email', with: admin.email)
    fill_in('admin_user_password', with: admin.password)
    click_button('Login')
    click_link('Books')
  end

  it 'displays book attribute' do
    book_attributes.each do |attribute|
      books.map(&:decorate).map(&attribute.to_sym).each do |text|
        expect(page).to have_content(text)
      end
    end
  end

  it 'displays book category' do
    books.map { |book| book.category.name }.each do |name|
      expect(page).to have_content(name)
    end
  end

  it 'displays book description' do
    books.map(&:description).each do |desc|
      expect(page).to have_content(desc)
    end
  end
end
