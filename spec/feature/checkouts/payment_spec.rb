# frozen_string_litereal: true

RSpec.describe 'Checkout Payment', type: :feature do
  let(:user) { create(:user) }
  let(:order_items) { create_list(:order_item, 3) }
  let!(:order) { create(:order, order_items: order_items, delivery_type: delivery_type, order_state: :payment) }
  let(:delivery_type) { create(:delivery_type) }
  let!(:billing_address) { create(:address, addressable: order, address_type: :billing) }
  let!(:shipping_address) { create(:address, addressable: order, address_type: :shipping) }

  before do
    page.set_rack_session(cart_id: order.id)
    sign_in(user)
  end

  describe 'card_form', js: true do
    let(:card_data) { attributes_for(:card) }

    context 'when valid input' do
      before do
        visit checkout_path
        fill_in(I18n.t('checkouts.payment.card_number'), with: card_data[:number])
        fill_in(I18n.t('checkouts.payment.name_on_card'), with: card_data[:name])
        fill_in(I18n.t('checkouts.payment.expire_date'), with: card_data[:expire_date])
        fill_in(I18n.t('checkouts.payment.cvv'), with: card_data[:cvv])
        click_button(I18n.t('checkouts.save_and_continue'))
      end

      it 'renders next page' do
        expect(page).to have_content(I18n.t('checkouts.confirm.place_order'))
      end
    end

    context 'when invalid input' do
      before do
        visit checkout_path
        click_button(I18n.t('checkouts.save_and_continue'))
      end

      it 'displays errors' do
        expect(page).to have_content(I18n.t('errors.messages.blank'))
      end
    end
  end
end
