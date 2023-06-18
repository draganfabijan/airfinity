# frozen_string_literal: true

module Reservations
  module Parser
    # ::Reservations::Parser::Factory
    class Factory
      def initialize(payload)
        @payload = payload
      end

      def parser
        if @payload.key?('reservation')
          Airbnb.new(@payload)
        elsif @payload.key?('reservation_code')
          BookingCom.new(@payload)
        else
          raise StandardError, 'Invalid payload'
        end
      end
    end
  end
end
