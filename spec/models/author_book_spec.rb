# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthorBook, type: :model do
  context 'with associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:author) }
  end
end
