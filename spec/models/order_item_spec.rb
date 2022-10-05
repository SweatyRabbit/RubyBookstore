# frozen_string_literal: true

RSpec.describe OrderItem, type: :model do
  context 'with associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:order) }
  end
end
