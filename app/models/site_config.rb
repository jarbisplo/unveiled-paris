class SiteConfig < ApplicationRecord
  validates :key, presence: true, uniqueness: true

  def self.get(key)
    find_by(key: key)&.value
  end

  def self.set(key, value)
    record = find_or_initialize_by(key: key)
    record.update!(value: value.to_s)
  end

  # Stripe Connect helpers
  def self.stripe_account_id
    get("stripe_account_id")
  end

  def self.stripe_connected?
    stripe_account_id.present?
  end

  def self.platform_fee_percent
    (get("platform_fee_percent") || "20").to_f
  end
end
