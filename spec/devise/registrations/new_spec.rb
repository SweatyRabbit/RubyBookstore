# frozen_string_literal: true

RSpec.describe 'New', type: :feature do
  let(:user_data) { attributes_for(:user) }

  before do
    visit new_user_registration_path
  end

  context 'when valid inputs' do
    before do
      fill_in(I18n.t('devise.enter_email'), with: user_data[:email])
      fill_in(I18n.t('devise.password'), with: user_data[:password])
      fill_in(I18n.t('devise.confirm_password'), with: user_data[:password])
      click_button(I18n.t('devise.sign_up'))
    end

    it 'register new user' do
      expect(page).to have_current_path(root_path)
    end
  end

  context 'when invalid inputs' do
    let(:wrong_email) { 'dwadwa' }
    let(:wrong_password) { 'saA' }

    before do
      fill_in(I18n.t('devise.enter_email'), with: wrong_email)
      fill_in(I18n.t('devise.password'), with: wrong_password)
      fill_in(I18n.t('devise.confirm_password'), with: wrong_password.reverse)
      click_button(I18n.t('devise.sign_up'))
    end

    it 'stays at ragistration page' do
      expect(page).to have_current_path(user_registration_path)
    end
  end
end
