# frozen_string_literal: true

RSpec.describe 'Show', type: :feature do
  let!(:admin) { create(:admin_user) }

  before do
    visit '/admin'
    fill_in('admin_user_email', with: admin.email)
    fill_in('admin_user_password', with: admin.password)
    click_button('Login')
    click_link('Books')
  end

  context 'with valid input' do
    let!(:category) { create(:category) }
    let!(:book) { create(:book, :with_authors) }

    before do
      visit new_admin_book_path
      page.select(category.name, from: 'book_category_id')
      fill_in('book_title', with: book.title)
      book.authors.each { |author| check("#{author.first_name} #{author.last_name}") }
      fill_in('book_description', with: book.description)
      fill_in('book_price', with: book.price)
      fill_in('book_publication_year', with: book.publication_year)
      fill_in('book_height', with: book.height)
      fill_in('book_width', with: book.width)
      fill_in('book_depth', with: book.depth)
      fill_in('book_materials', with: book.materials)
      click_button('commit')
    end

    it 'shows successfull message' do
      expect(page).to have_content('Book was successfully created.')
    end
  end

  context 'with invalid input' do
    let(:errors) { [must_exist, no_blank, price_error] }
    let(:must_exist) { 'must exist' }
    let(:no_blank) { "can't be blank" }
    let(:price_error) { "can't be blank and is not a number" }

    before do
      visit new_admin_book_path
      click_button('commit')
    end

    it 'shows error messages' do
      errors.each do |error|
        expect(page).to have_content(error)
      end
    end
  end
end
