# frozen_string_literal: true

# Reservation
class Reservation < ApplicationRecord

  # Constants
  SOURCE_AIRBNB = "AirBNB"
  SOURCE_BOOKING_COM = "Booking.com"

  # Associations
  belongs_to :guest

  # Validations
  validates :code, presence: true, uniqueness: true
  validates :start_date, :end_date, presence: true

  # OBSERVATION:
  # Since the data that is coming from platforms is very important for this product
  # and it can be changed.
  # I would consider adding some library like https://github.com/paper-trail-gem/paper_trail for versioning
  # for both Reservation and Guest. This could save a tone of time when debugging.

end
