# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'GET /index' do
    before { get books_path }

    it 'returns http success' do
      expect(response).to be_ok
    end

    it 'render books index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /books/:id' do
    context 'with valid book id' do
      let(:book) { create(:book) }

      before { get book_path(book) }

      it 'return http success' do
        expect(response).to be_ok
      end

      it 'render book template' do
        expect(response).to render_template(:show)
      end
    end
  end
end
