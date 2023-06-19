FactoryBot.define do
  factory :reservation do
    association    :guest
    code           { "YYY12345678" }
    start_date     { "2023-06-17" }
    end_date       { "2023-06-18" }
    currency       { "AUD" }
    status         { "accepted" }
    nights         { 1 }
    payout_price   { "900.99" }
    security_price { "100.99" }
    total_price    { "1000.99" }
    total_number_of_guests { 4 }
    number_of_adults       { 2 }
    number_of_children     { 1 }
    number_of_infants      { 1 }
    source                 { Reservation::SOURCE_BOOKING_COM }
  end
end
