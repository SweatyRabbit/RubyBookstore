# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'HomePages', type: :request do
  describe '/GET' do
    before { get root_path }

    it 'return http success' do
      expect(response).to have_http_status(:success)
    end

    it 'render home template' do
      expect(response).to render_template(:home)
    end
  end
end
