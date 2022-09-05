# frozen_string_literal: true

RSpec.describe 'Edit', type: :feature do
  %i[billing shipping].each do |address_type|
    describe address_type do
      let(:address_data) { attributes_for(:address, address_type: address_type) }
      let(:user) { create(:user) }

      before do
        sign_in(user)
        visit edit_user_registration_path
      end

      context 'with valid input' do
        before do
          within "##{address_type}_address" do
            fill_in(I18n.t('addresses.first_name'), with: address_data[:first_name])
            fill_in(I18n.t('addresses.last_name'), with: address_data[:last_name])
            fill_in(I18n.t('addresses.city'), with: address_data[:city])
            fill_in(I18n.t('addresses.address'), with: address_data[:address])
            fill_in(I18n.t('addresses.zip'), with: address_data[:zip])
            page.select(address_data[:country], from: 'address_country')
            fill_in(I18n.t('addresses.phone'), with: address_data[:phone])
            click_button(I18n.t('addresses.save'))
          end
        end

        it 'returns success message' do
          expect(page).to have_content(I18n.t('addresses.form.success', type: address_type))
        end
      end

      context 'with invalid iput' do
        before do
          within "##{address_type}_address" do
            click_button(I18n.t('addresses.save'))
          end
        end

        it 'stays at address page' do
          expect(page).to have_current_path(edit_user_registration_path)
        end
      end
    end
  end

  describe 'password change' do
    let!(:user) { create(:user) }

    before do
      sign_in(user)
      visit edit_user_registration_path
      page.find('#privacy').click
    end

    context 'with valid input' do
      before do
        within '#password-form' do
          fill_in(I18n.t('devise.current_password'), with: user.password)
          fill_in(I18n.t('devise.new_password'), with: user.password)
          fill_in(I18n.t('devise.confirm_password'), with: user.password)
          click_button(I18n.t('addresses.save'))
        end
      end

      it 'saves new password' do
        expect(page).to have_content(I18n.t('devise.registrations.updated'))
      end
    end

    context 'with invalid input' do
      let(:invalid_password) { '1' }

      before do
        within '#password-form' do
          fill_in(I18n.t('devise.current_password'), with: invalid_password)
          fill_in(I18n.t('devise.new_password'), with: invalid_password)
          click_button(I18n.t('addresses.save'))
        end
      end

      it 'stays on the same page and show errors' do
        expect(page).to have_content(I18n.t('errors.messages.invalid'))
        expect(page).to have_content(I18n.t('errors.messages.too_short.other', count: 6))
      end
    end
  end

  describe 'email change' do
    let!(:user) { create(:user) }

    before do
      sign_in(user)
      visit edit_user_registration_path
      page.find('#privacy').click
    end

    context 'with valid input' do
      let(:new_email) { FFaker::Internet.email }

      before do
        within '#email-form' do
          fill_in(I18n.t('devise.enter_email'), with: new_email)
          click_button(I18n.t('addresses.save'))
        end
      end

      it 'saves email' do
        expect(page).to have_content(I18n.t('devise.registrations.updated'))
      end
    end

    context 'with invalid input' do
      let(:wrong_email) { 'aboba' }

      before do
        within '#email-form' do
          fill_in(I18n.t('devise.enter_email'), with: wrong_email)
          click_button(I18n.t('addresses.save'))
        end
      end

      it 'stays on the same page end shows the error' do
        expect(page).to have_content(I18n.t('errors.messages.invalid'))
      end
    end
  end
end
