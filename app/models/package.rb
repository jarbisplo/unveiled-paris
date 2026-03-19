class Package < ApplicationRecord
  has_many :bookings

  validates :name, :slug, :price_cents, :duration, presence: true

  def formatted_price
    total = price_cents / 100
    total >= 1000 ? "$#{total.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}" : "$#{total}"
  end

  def price_label
    tagline.to_s.include?("per tour") ? "per tour" : "per person"
  end

  def price
    price_cents / 100.0
  end
end
