RSpec.describe ::Reservations::Parser::Factory do
  describe "#parser" do

    subject(:factory) { described_class.new(payload).parser }

    context "when payload has reservation key" do
      let(:payload) { { "reservation_code" => {} } }

      it "calls parse method on Reservations::Parser::Airbnb instance" do
        airbnb_parser = instance_double(::Reservations::Parser::Airbnb)
        expect(::Reservations::Parser::Airbnb).to receive(:new).with(payload).and_return(airbnb_parser)
        expect(airbnb_parser).to receive(:parse)

        factory
      end
    end

    context "when payload has reservation_code key" do
      let(:payload) { { "reservation" => "YYY12345678" } }

      it "calls parse method on Reservations::Parser::BookingCom instance" do
        booking_com_parser = instance_double(::Reservations::Parser::BookingCom)
        expect(::Reservations::Parser::BookingCom).to receive(:new).with(payload).and_return(booking_com_parser)
        expect(booking_com_parser).to receive(:parse)

        factory
      end
    end

    context "when payload is invalid" do
      let(:payload) { { "invalid_key" => {} } }

      it "raises StandardError" do
        expect { factory }.to raise_error(StandardError, "Invalid payload")
      end
    end

  end
end
