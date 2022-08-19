# frozen_string_literal: true

RSpec.describe 'New', type: :feature do
  let!(:user) { create(:user) }

  before do
    visit new_user_session_path
  end

  context 'with valid input' do
    before do
      fill_in(I18n.t('devise.email'), with: user.email)
      fill_in(I18n.t('devise.password'), with: user.password)
      click_button(I18n.t('devise.log_in'))
    end

    it 'authorize use' do
      expect(page).to have_current_path(root_path)
    end
  end

  context 'with invalid input' do
    before do
      click_button(I18n.t('devise.log_in'))
    end

    it 'stays at log in page' do
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
