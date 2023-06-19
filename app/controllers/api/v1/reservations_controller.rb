# frozen_string_literal: true

module Api
  module V1
    # Api::V1::ReservationsController
    class ReservationsController < ApplicationController

      def create
        reservation_data = ::Reservations::Parser::Factory.new(payload).parser

        begin
          ActiveRecord::Base.transaction do
            guest = ::Guests::CreateOrUpdate.new(reservation_data[:guest]).call!
            ::Reservations::CreateOrUpdate.new(guest, reservation_data[:reservation]).call!
          end

          render json: { message: "Reservation successfully created or updated." }, status: :ok
        rescue ActiveRecord::RecordInvalid => e
          render json: { message: e.message }, status: :unprocessable_entity
        rescue StandardError => e
          render json: { message: e.message }, status: :internal_server_error
        end
      end

      private

      def payload
        params.permit!.except(:controller, :action).to_h
      end

    end
  end
end
