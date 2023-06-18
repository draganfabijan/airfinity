RSpec.describe Reservations::Parser::Airbnb do
  describe '#parse' do

    subject(:parser) { described_class.new(payload) }

    let(:payload) do
      {
        "reservation_code" => "YYY12345678",
        "start_date" => "2021-04-14",
        "end_date" => "2021-04-18",
        "nights" => 4,
        "guests" => 4,
        "adults" => 2,
        "children" => 2,
        "infants" => 0,
        "status" => "accepted",
        "guest" => {
          "first_name" => "Wayne",
          "last_name" => "Woodbridge",
          "phone" => "639123456789",
          "email" => "wayne_woodbridge@bnb.com"
        },
        "currency" => "AUD",
        "payout_price" => "4200.00",
        "security_price" => "500",
        "total_price" => "4700.00"
      }
    end

    it 'returns the parsed guest and reservation data' do
      parsed_data = parser.parse

      expect(parsed_data).to include(
        guest: {
          first_name: "Wayne",
          last_name: "Woodbridge",
          email: "wayne_woodbridge@bnb.com",
          phone_numbers: ["639123456789"]
        },
        reservation: {
          code: "YYY12345678",
          start_date: "2021-04-14",
          end_date: "2021-04-18",
          status: "accepted",
          nights: 4,
          payout_price: "4200.00",
          security_price: "500",
          total_price: "4700.00",
          currency: "AUD",
          total_number_of_guests: 4,
          number_of_adults: 2,
          number_of_children: 2,
          number_of_infants: 0
        }
      )
    end
  end
end