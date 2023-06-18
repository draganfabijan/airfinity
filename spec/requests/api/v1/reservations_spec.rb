RSpec.describe Api::V1::ReservationsController, type: :controller do
  describe "POST #create" do
    let(:payload) do
      {
        "reservation" => {
          "guest_first_name" => "Johny",
          "guest_last_name" => "Cash",
          "guest_email" => "johny.cash@example.com",
          "guest_phone_numbers" => ["123456789", "987654321"],
          "code" => "ABC123",
          "start_date" => "2022-01-01",
          "end_date" => "2022-01-05",
          "expected_payout_amount" => "100.00",
          "guest_details" => {
            "number_of_guests" => "2",
            "number_of_adults" => "2",
            "number_of_children" => "0",
            "number_of_infants" => "0"
          },
          "status_type" => "accepted",
          "host_currency" => "USD",
          "listing_security_price_accurate" => "50.00",
          "total_paid_amount_accurate" => "150.00"
        }
      }
    end

    context "with valid payload" do
      it "calls the parser factory and renders a success response" do
        expect(::Reservations::Parser::Factory).to receive(:new).with(payload).and_call_original
        expect_any_instance_of(::Reservations::Parser::Factory).to receive(:parser)

        post :create, params: payload

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({ message: "Reservation successfully parsed." }.to_json)
      end
    end

    context "when an error occurs during parsing" do
      before do
        allow_any_instance_of(::Reservations::Parser::Factory).to receive(:parser).and_raise(StandardError, "Parsing error")
      end

      it "renders an internal server error response" do
        post :create, params: payload

        expect(response).to have_http_status(:internal_server_error)
        expect(response.body).to eq({ message: "Parsing error" }.to_json)
      end
    end
  end
end