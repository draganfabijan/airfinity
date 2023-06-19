RSpec.describe Api::V1::ReservationsController, type: :controller do
  describe "POST #create" do

    subject { post :create, params: payload }

    let(:payload) do
      {
        "reservation": {
          "code": "XXX12345678",
          "start_date": "2021-03-12",
          "end_date": "2021-03-16",
          "expected_payout_amount": "3800.00",
          "guest_details": {
            "localized_description": "4 guests",
            "number_of_adults": 2,
            "number_of_children": 2,
            "number_of_infants": 0
          },
          "guest_email": "wayne_woodbridge@bnb.com",
          "guest_first_name": "Wayne",
          "guest_last_name": "Woodbridge",
          "guest_phone_numbers": [
            "639123456789",
            "639123456789"
          ],
          "listing_security_price_accurate": "500.00",
          "host_currency": "AUD",
          "nights": 4,
          "number_of_guests": 4,
          "status_type": "accepted",
          "total_paid_amount_accurate": "4300.00"
        }
      }
    end

    context "with valid payload" do
      let(:guest) { instance_double(Guest) }
      let(:reservation_data) do
        {
          "guest": {
            "first_name": "Wayne",
            "last_name": "Woodbridge",
            "email": "wayne_woodbridge@bnb.com",
            "phone_numbers": "639123456789, 639123456789"
          },
          "reservation": {
            "code": "XXX12345678",
            "start_date": "2021-03-12",
            "end_date": "2021-03-16",
            "status": "accepted",
            "nights": "4",
            "payout_price": "3800.00",
            "security_price": "500.00",
            "total_price": "4300.00",
            "currency": "AUD",
            "total_number_of_guests": "4",
            "number_of_adults": "2",
            "number_of_children": "2",
            "number_of_infants": "0",
            "source": "Booking.com"
          }
        }
      end
      before do
        allow(controller).to receive(:params).and_return(ActionController::Parameters.new(payload))
        allow(::Reservations::Parser::Factory).to receive_message_chain(:new, :parser).and_return(reservation_data)
        allow(::Guests::CreateOrUpdate).to receive_message_chain(:new, :call!).and_return(guest)
        allow(::Reservations::CreateOrUpdate).to receive_message_chain(:new, :call!)
      end

      it "calls the expected services with correct arguments" do
        subject

        expect(::Reservations::Parser::Factory).to have_received(:new).with(payload)
        expect(::Reservations::Parser::Factory.new(payload)).to have_received(:parser)
        expect(::Guests::CreateOrUpdate).to have_received(:new).with(reservation_data[:guest])
        expect(::Guests::CreateOrUpdate.new(reservation_data[:guest])).to have_received(:call!)
        expect(::Reservations::CreateOrUpdate).to have_received(:new).with(guest, reservation_data[:reservation])
        expect(::Reservations::CreateOrUpdate.new(guest, reservation_data[:reservation])).to have_received(:call!)
      end

      it "responds with :ok status and returns success message" do
        subject

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["message"]).to eq("Reservation successfully created or updated.")
      end
    end

    context "when a RecordInvalid error is raised" do
      before do
        allow_any_instance_of(Guests::CreateOrUpdate).to receive(:call!).and_raise(ActiveRecord::RecordInvalid)
      end

      it "responds with :unprocessable_entity status and returns error message" do
        expect { subject }.not_to change { Guest.count }
        expect { subject }.not_to change { Reservation.count }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["message"]).to eq("Record invalid")
      end
    end

    context "when a StandardError is raised" do
      before do
        allow_any_instance_of(Guests::CreateOrUpdate).to receive(:call!).and_raise(StandardError)
      end

      it "responds with :internal_server_error and returns error message" do
        expect { subject }.not_to change { Guest.count }
        expect { subject }.not_to change { Reservation.count }

        expect(response).to have_http_status(:internal_server_error)
        expect(JSON.parse(response.body)["message"]).to eq("StandardError")
      end
    end

  end
end
