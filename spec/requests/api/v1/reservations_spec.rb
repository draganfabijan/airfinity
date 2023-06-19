RSpec.describe Api::V1::ReservationsController, type: :controller do
  describe "POST #create" do

    subject { post :create, params: payload }

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
        expect { subject }.to change { Guest.count }.by(1)
          .and change { Reservation.count }.by(1)

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({ message: "Reservation successfully created or updated." }.to_json)
      end
    end

  end
end