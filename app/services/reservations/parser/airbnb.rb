# frozen_string_literal: true

module Reservations
  module Parser
    # Reservations::Parser::Airbnb.new(payload).parse
    class Airbnb
      def initialize(payload)
        @payload = payload
      end

      def parse
        {
          guest: parse_guest,
          reservation: parse_reservation
        }
      end

      private

      def parse_guest
        {
          first_name: @payload.dig("guest", "first_name"),
          last_name: @payload.dig("guest", "last_name"),
          email: @payload.dig("guest", "email"),
          phone_numbers: [@payload.dig("guest", "phone")]
        }
      end

      def parse_reservation
        {
          code: @payload["reservation_code"],
          start_date: @payload["start_date"],
          end_date: @payload["end_date"],
          status: @payload["status"],
          nights: @payload["nights"],
          payout_price: @payload["payout_price"],
          security_price: @payload["security_price"],
          total_price: @payload["total_price"],
          currency: @payload["currency"],
          total_number_of_guests: @payload["guests"],
          number_of_adults: @payload["adults"],
          number_of_children: @payload["children"],
          number_of_infants: @payload["infants"],
          source: Reservation::SOURCE_AIRBNB
        }
      end
    end
  end
end
