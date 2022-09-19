# frozen_string_literal: true

RSpec.describe Coupon, type: :model do
  context 'with associations' do
    it { is_expected.to belong_to(:order).optional(true) }
  end
end
