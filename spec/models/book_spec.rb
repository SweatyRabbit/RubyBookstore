# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'with associations' do
    it { is_expected.to have_many(:author_books).dependent(:destroy) }
    it { is_expected.to have_many(:authors).through(:author_books) }
    it { is_expected.to belong_to(:category) }
  end
end
