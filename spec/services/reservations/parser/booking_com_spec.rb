RSpec.describe Reservations::Parser::BookingCom do

  subject(:parser) { described_class.new(payload) }

  let(:payload) do
    {
      "reservation" => {
        "guest_first_name" => "John",
        "guest_last_name" => "Cash",
        "guest_email" => "john.cash@example.com",
        "guest_phone_numbers" => ["639123456789", "987654321"],
        "code" => "ABC123",
        "start_date" => "2023-01-01",
        "end_date" => "2023-01-05",
        "expected_payout_amount" => "100.00",
        "guest_details" => {
          "number_of_guests" => 2,
          "number_of_adults" => 2,
          "number_of_children" => 0,
          "number_of_infants" => 0
        },
        "status_type" => "accepted",
        "host_currency" => "AUD",
        "listing_security_price_accurate" => "50.00",
        "total_paid_amount_accurate" => "150.00",
        "nights" => 2
      }
    }
  end

  describe "#parse" do
    it "returns the parsed guest and reservation data" do
      parsed_data = parser.parse

      expect(parsed_data).to include(
        guest: {
          first_name: "John",
          last_name: "Cash",
          email: "john.cash@example.com",
          phone: "639123456789, 987654321"
        },
        reservation: {
          code: "ABC123",
          start_date: "2023-01-01",
          end_date: "2023-01-05",
          total_number_of_guests: 2,
          number_of_adults: 2,
          number_of_children: 0,
          number_of_infants: 0,
          status: "accepted",
          payout_price: "100.00",
          currency: "AUD",
          security_price: "50.00",
          total_price: "150.00",
          nights: 2
        }
      )
    end
  end
end