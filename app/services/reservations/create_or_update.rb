# frozen_string_literal: true

module Reservations
  # Reservations::CreateOrUpdate.new(guest, reservation_data).call
  class CreateOrUpdate
    def initialize(guest, reservation_data)
      @guest = guest
      @reservation_data = reservation_data
    end

    def call!
      reservation = find_or_initialize_reservation
      reservation.assign_attributes(@reservation_data)
      reservation.guest = @guest
      reservation.save!
    end

    private

    def find_or_initialize_reservation
      Reservation.find_or_initialize_by(code: @reservation_data[:code])
    end
  end
end