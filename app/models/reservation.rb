# frozen_string_literal: true

class Reservation < ApplicationRecord

  # Constants
  SOURCE_AIRBNB = "AirBNB"
  SOURCE_BOOKING_COM = "Booking.com"

  # Associations
  belongs_to :guest

  # Validations
  validates :code, presence: true, uniqueness: true
  validates :start_date, :end_date, presence: true

end
