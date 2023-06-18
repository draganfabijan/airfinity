RSpec.describe ::Reservations::Parser::Factory do
  describe "#parser" do

    subject(:factory) { described_class.new(payload) }

    context "when payload has reservation key" do
      let(:payload) { { "reservation" => {} } }

      it "returns an instance of Airbnb" do
        expect(factory.parser).to be_instance_of(::Reservations::Parser::Airbnb)
      end
    end

    context "when payload has reservation_code key" do
      let(:payload) { { "reservation_code" => {} } }

      it "returns an instance of Booking" do
        expect(factory.parser).to be_instance_of(::Reservations::Parser::BookingCom)
      end
    end

    context "when payload is invalid" do
      let(:payload) { { "invalid_key" => {} } }

      it "raises StandardError" do
        expect { factory.parser }.to raise_error(StandardError, "Invalid payload")
      end
    end
  end
end
