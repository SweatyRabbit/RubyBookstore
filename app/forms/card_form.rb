# frozen_string_literal: true

class CardForm
  include ActiveModel::Model

  attr_accessor :number, :name, :expire_date, :cvv

  FORMAT = {
    text: /\A[a-zA-Z\s]+\z/,
    numeric: /\A\d+\z/,
    date: %r/\b(0[1-9]|1[0-2])\/?([0-9]{4}|[0-9]{2})\b/
  }.freeze

  LENGTH = {
    max_name: 50,
    min_cvv: 3,
    max_cvv: 4
  }.freeze

  validates :number, :name, :expire_date, :cvv, presence: true
  validates :name, format: { with: FORMAT[:text] }, length: { maximum: LENGTH[:max_name] }
  validates :cvv, format: { with: FORMAT[:numeric] }, length: { minimum: LENGTH[:min_cvv], maximum: LENGTH[:max_cvv] }
  validates :number, format: { with: FORMAT[:numeric] }
  validates :expire_date, format: { with: FORMAT[:date] }

  def save(object)
    return false if invalid?

    object.create_card(params)
  end

  def params
    {
      name: name,
      number: number,
      expire_date: expire_date,
      cvv: cvv
    }
  end
end
