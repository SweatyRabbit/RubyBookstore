# frozen_string_literal: true

RSpec.describe 'Index', type: :feature do
  let!(:admin) { create(:admin_user) }
  let(:reviews_properties) { %i[title status book_rate] }

  before do
    visit '/admin'
    fill_in('admin_user_email', with: admin.email)
    fill_in('admin_user_password', with: admin.password)
    click_button('Login')
  end

  describe 'unprocessed scope' do
    let!(:unprocessed_scope) { create(:review, status: Review.statuses[:unprocessed]) }

    before do
      click_link('Reviews')
    end

    it 'displayes unprocessed reviews' do
      reviews_properties.each do |property|
        expect(page).to have_content(unprocessed_scope[property])
      end
    end
  end

  describe 'processed scope' do
    let!(:processed_scope) { create(:review) }

    before do
      click_link('Reviews')
      click_link('Processed')
    end

    it 'displays processed reviews' do
      reviews_properties.each do |property|
        expect(page).to have_content(processed_scope[property])
      end
    end
  end
end
