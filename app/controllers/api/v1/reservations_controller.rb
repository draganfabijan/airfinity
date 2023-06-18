# frozen_string_literal: true

module Api
  module V1
    class ReservationsController < ApplicationController

      def create
        ::Reservations::Parser::Factory.new(payload).parser
        # TODO: Add services that will create or update guest and reservation
        render json: { message: "Reservation successfully parsed." }, status: :ok
      rescue StandardError => e
        render json: { message: e.message }, status: :internal_server_error
      end

      private

      def payload
        params.permit!.except(:controller, :action).to_h
      end

    end
  end
end
