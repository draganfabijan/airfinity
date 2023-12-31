# frozen_string_literal: true

module Reservations
  module Parser
    # ::Reservations::Parser::Factory.new(payload).parser
    class Factory
      def initialize(payload)
        @payload = payload
      end

      def parser
        if @payload.key?("reservation_code")
          Airbnb.new(@payload).parse
        elsif @payload.key?("reservation")
          BookingCom.new(@payload).parse
        else
          raise StandardError, "Invalid payload"
        end
      end

    end
  end
end
