# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'with association' do
    it { is_expected.to have_many(:books).dependent(:destroy) }
  end
end
