# frozen_string_literal: true

RSpec.describe 'Checkout Delivery', type: :feature do
  let(:user) { create(:user) }
  let(:order_items) { create_list(:order_item, 3) }
  let(:order) { create(:order, order_items: order_items, order_state: :delivery) }
  let!(:delivery_types) { create_list(:delivery_type, 3) }

  before do
    sign_in(user)
    page.set_rack_session(cart_id: order.id)
  end

  describe 'delivery types' do
    before { visit checkout_path }

    it 'displays delivery types name' do
      delivery_types.map(&:name).each do |name|
        expect(page).to have_content(name)
      end
    end
  end

  describe 'delivery type form' do
    before do
      visit checkout_path
      within 'div.hidden-xs.mb-res-50' do
        click_button(I18n.t('checkouts.save_and_continue'))
      end
    end

    it 'renders next page' do
      expect(page).to have_content(I18n.t('checkouts.payment.credit_card'))
    end
  end
end
