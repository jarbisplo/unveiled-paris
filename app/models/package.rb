class Package < ApplicationRecord
  has_many :bookings

  validates :name, :slug, :price_cents, :duration, presence: true

  def formatted_price
    "$#{price_cents / 100}"
  end

  def price
    price_cents / 100.0
  end
end
