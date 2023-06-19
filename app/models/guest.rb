# frozen_string_literal: true

# Guest
class Guest < ApplicationRecord

  # Associations
  has_many :reservations, dependent: :destroy

  # Validations
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is invalid" }
  validates :first_name, :last_name, :phone_numbers, presence: true

end
