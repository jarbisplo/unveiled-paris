class Booking < ApplicationRecord
  belongs_to :package

  enum :status, { pending: 0, confirmed: 1, cancelled: 2 }

  validates :first_name, :last_name, :email, :phone, :tour_date, :group_size, :package, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :group_size, inclusion: { in: 1..6, message: "must be between 1 and 6" }

  def full_name
    "#{first_name} #{last_name}"
  end
end
