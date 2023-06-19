# frozen_string_literal: true

# Guest
class Guest < ApplicationRecord

  # Constants
  # TODO: Decide for what countries do we want to validate phone numbers
  # VALID_PHONE_REGEX = /^(?:\+?(61))? ?(?:\((?=.*\)))?(0?[2-57-8])\)? ?(\d\d(?:[- ](?=\d{3})|(?!\d\d[- ]?\d[- ]))\d\d[- ]?\d[- ]?\d{3})$/


  # Associations
  has_many :reservations, dependent: :destroy

  # Validations
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is invalid" }
  validates :first_name, :last_name, :phone_numbers, presence: true
  # validate :phone_numbers_are_valid

  private

  # def phone_numbers_are_valid
  #   phone_numbers.each do |phone_number|
  #     errors.add(:phone_numbers, "#{phone_number} is not a valid phone number") unless phone_number.match?(VALID_PHONE_REGEX)
  #   end
  # end


end
