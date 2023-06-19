RSpec.describe Reservations::CreateOrUpdate, type: :service do
  describe "#call!" do

    subject { described_class.new(guest, reservation_data).call! }

    let(:guest) { FactoryBot.create(:guest) }
    let(:reservation_data) do
      {
        code: "R1234",
        start_date: Date.today,
        end_date: Date.today + 5.days,
        status: "accepted",
        nights: 5,
        payout_price: 100.00,
        security_price: 50.00,
        total_price: 150.00,
        currency: "USD",
        total_number_of_guests: 2,
        number_of_adults: 2,
        number_of_children: 0,
        number_of_infants: 0,
        source: Reservation::SOURCE_BOOKING_COM
      }
    end

    context "when a new reservation is created" do
      it "creates a reservation with correct attributes" do
        expect { subject }.to change(Reservation, :count).by(1)

        reservation = Reservation.find_by(code: reservation_data[:code])
        expect(reservation.guest).to eq(guest)
        expect(reservation.start_date).to eq(reservation_data[:start_date])
        expect(reservation.end_date).to eq(reservation_data[:end_date])
        expect(reservation.status).to eq(reservation_data[:status])
        expect(reservation.nights).to eq(reservation_data[:nights])
        expect(reservation.payout_price).to eq(reservation_data[:payout_price])
        expect(reservation.security_price).to eq(reservation_data[:security_price])
        expect(reservation.total_price).to eq(reservation_data[:total_price])
        expect(reservation.currency).to eq(reservation_data[:currency])
        expect(reservation.total_number_of_guests).to eq(reservation_data[:total_number_of_guests])
        expect(reservation.number_of_adults).to eq(reservation_data[:number_of_adults])
        expect(reservation.number_of_children).to eq(reservation_data[:number_of_children])
        expect(reservation.number_of_infants).to eq(reservation_data[:number_of_infants])
        expect(reservation.source).to eq(reservation_data[:source])
      end
    end

    context "when an existing reservation is updated" do
      let!(:existing_reservation) { FactoryBot.create(:reservation, guest: guest, code: reservation_data[:code]) }

      let(:reservation_data) do
        {
          code: "R1234",
          status: "rejected"
        }
      end

      it "does not create a new reservation" do
        expect { subject }.not_to change(Reservation, :count)
      end

      it "updates the reservation with correct attributes" do
        subject

        expect(existing_reservation.reload.status).to eq("rejected")
      end
    end

    context "when start_date is blank" do
      before { reservation_data[:start_date] = nil }

      it "raises an error" do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Start date can't be blank")
      end
    end
  end
end
