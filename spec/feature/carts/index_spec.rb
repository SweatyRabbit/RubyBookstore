# frozen_string_literal: true

RSpec.describe 'carts#show', type: :feature do
  let!(:order) { create(:order, order_items: order_items) }
  let(:order_items) { create_list(:order_item, 1) }

  before do
    page.set_rack_session(cart_id: order.id)
    visit cart_path
  end

  describe 'delete ordered item from cart', js: true do
    subject { page.all('a.close.general-cart-close').count }

    let!(:expected_result) { page.all('a.close.general-cart-close').count - 1 }

    before do
      within 'table.table.table-hover' do
        page.all('a.close.general-cart-close').first.click
      end
    end

    it { is_expected.to eq(expected_result) }
  end

  describe 'book amount increasing', js: true do
    subject { page.all('input.form-control.quantity-input').first.value.to_i }

    let!(:expected_result) { page.all('input.form-control.quantity-input').first.value.to_i + 1 }

    before do
      within 'table.table.table-hover' do
        page.all('i.fa.fa-plus').first.click
      end
      sleep(0.5)
      page.refresh
    end

    it { is_expected.to eq(expected_result) }
  end

  describe 'book amount decreasing', js: true do
    subject { page.all('input.form-control.quantity-input').first.value.to_i }

    let!(:expected_result) { page.all('input.form-control.quantity-input').first.value.to_i - 1 }

    before do
      within 'table.table.table-hover' do
        page.all('i.fa.fa-minus').first.click
      end
      sleep(0.5)
      page.refresh
    end

    it { is_expected.to eq(expected_result) }
  end

  describe 'coupon feature' do
    context 'when using invalid coupon' do
      let(:invalid_coupon) { 'invalid' }

      before do
        fill_in(I18n.t('cart.enter_coupon_code'), with: invalid_coupon)
        click_button(I18n.t('button.apply_coupon'))
      end

      it 'displays error message' do
        expect(page).to have_content(I18n.t('cart.invalid_coupon'))
      end
    end

    context 'when using valid coupon' do
      let(:valid_coupon) { create(:coupon) }

      before do
        fill_in(I18n.t('cart.enter_coupon_code'), with: valid_coupon.code)
        click_button(I18n.t('button.apply_coupon'))
      end

      it 'adds coupon' do
        expect(page).to have_content(I18n.t('cart.coupon_added'))
      end
    end

    context 'when using already used coupon' do
      let(:used_coupon) { create(:coupon, active: false) }

      before do
        fill_in(I18n.t('cart.enter_coupon_code'), with: used_coupon.code)
        click_button(I18n.t('button.apply_coupon'))
      end

      it 'adds coupon' do
        expect(page).to have_content(I18n.t('cart.coupon_used'))
      end
    end
  end
end
