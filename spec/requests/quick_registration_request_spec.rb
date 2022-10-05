# frozen_string_literal: true

RSpec.describe 'QuickRegistrationsRequest', type: :request do
  describe 'GET /quick_registration' do
    before { get quick_registration_path }

    it 'returns http ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders show template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'POST /quick_registration' do
    context 'when params are valid' do
      let(:valid_email) { attributes_for(:user)[:email] }

      before do
        post quick_registration_path, params: { user: { email: valid_email } }
      end

      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
      end

      it 'redirect to checkout path' do
        expect(response).to redirect_to(checkout_path)
      end
    end

    context 'when invalid params' do
      let(:invalid_email) { 'dsa' }

      before do
        post quick_registration_path, params: { user: { email: invalid_email } }
      end

      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to quick registration path' do
        expect(response).to redirect_to(quick_registration_path)
      end
    end
  end
end
