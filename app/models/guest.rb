class Guest < ApplicationRecord

  # Constants
  VALID_EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/

  # Associations
  has_many :reservations, dependent: :destroy

  # Validations
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :first_name, :last_name, :phone_numbers, presence: true

end
