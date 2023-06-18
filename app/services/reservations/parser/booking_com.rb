# frozen_string_literal: true

module Reservations
  module Parser
    # Reservations::Parser::BookingCom.new(payload).parse
    class BookingCom
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
        guest_info = @payload['reservation']
        phone_numbers = guest_info['guest_phone_numbers'].presence

        {
          first_name: guest_info['guest_first_name'],
          last_name: guest_info['guest_last_name'],
          email: guest_info['guest_email'],
          phone: phone_numbers ? phone_numbers.join(', ') : nil
        }
      end

      def parse_reservation
        reservation_info = @payload['reservation']

        {
          code: reservation_info['code'],
          start_date: reservation_info['start_date'],
          end_date: reservation_info['end_date'],
          status: reservation_info['status_type'],
          nights: reservation_info['nights'],
          payout_price: reservation_info['expected_payout_amount'],
          security_price: reservation_info['listing_security_price_accurate'],
          total_price: reservation_info['total_paid_amount_accurate'],
          currency: reservation_info['host_currency'],
          total_number_of_guests: reservation_info['guest_details']['number_of_guests'],
          number_of_adults: reservation_info['guest_details']['number_of_adults'],
          number_of_children: reservation_info['guest_details']['number_of_children'],
          number_of_infants: reservation_info['guest_details']['number_of_infants']
        }
      end
    end
  end
end
