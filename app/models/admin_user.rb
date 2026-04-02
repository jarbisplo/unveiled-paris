class AdminUser < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  validates :name, presence: true

  def display_name
    name.presence || email
  end
end
