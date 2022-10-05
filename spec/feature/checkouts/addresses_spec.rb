# frozen_string_literal: true

RSpec.describe 'Checkout Addresses', type: :feature do
  let(:user) { create(:user) }

  before do
    sign_in(user)
    visit checkout_path
  end

  describe 'addresses form', js: true do
    let(:address_data) { attributes_for(:address) }

    context 'when valid input' do
      before do
        within 'div.col-md-5.mb-40' do
          fill_in(I18n.t('addresses.first_name'), with: address_data[:first_name])
          fill_in(I18n.t('addresses.last_name'), with: address_data[:last_name])
          fill_in(I18n.t('addresses.city'), with: address_data[:city])
          fill_in(I18n.t('addresses.address'), with: address_data[:address])
          fill_in(I18n.t('addresses.zip'), with: address_data[:zip])
          page.select(address_data[:country], from: 'order_billing_address_country')
          fill_in(I18n.t('addresses.phone'), with: address_data[:phone])
        end
        page.find('span.checkbox-icon').click
        click_button(I18n.t('checkouts.save_and_continue'))
      end

      it 'renders next page' do
        expect(page).to have_content(I18n.t('checkouts.delivery.price'))
      end
    end

    context 'when invalid input' do
      before do
        click_button(I18n.t('checkouts.save_and_continue'))
      end

      it 'shows errors' do
        expect(page).to have_content(I18n.t('errors.messages.blank'))
      end
    end
  end
end
