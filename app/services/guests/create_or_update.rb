# frozen_string_literal: true

module Guests
  # Guests::CreateOrUpdate.new(guest_data).call
  class CreateOrUpdate
    def initialize(guest_data)
      @guest_data = guest_data
    end

    def call
      guest = find_or_initialize_guest
      guest.assign_attributes(@guest_data)
      guest.save!
      guest
    end

    private

    # OBSERVATION:
    # Since this app will receive reservations from both booking.com and airbnb
    # and in both platforms email address is editable field. We can expect issues with data consistency.
    # For example different reservation data with a same email address will be imported from both platforms
    # and that guest details will be overriden.
    # Solution for this would be to add a new column in guest model that would be able to store source, like ["airbnb", "booking.com"]
    # then if guest exist in DB and email is changed we can call a method on guest to check if guest have reservations from other platform.
    # This would help us to determine whether a new guest should be created for the platfrom from
    # which one request is coming. Also, we would update all reservations from this platform with a new guest_id.
    # There could be also an issues with different phone numbers. But before any work I would consult PM and other developers for their tought.
    def find_or_initialize_guest
      Guest.find_or_initialize_by(email: @guest_data[:email])
    end
  end
end




