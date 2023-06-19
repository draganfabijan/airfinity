RSpec.describe Guests::CreateOrUpdate do
  describe "#call!" do

    subject { described_class.new(guest_data).call! }

    context "with valid guest data" do
      let(:guest_data) do
        {
          email: "tom.evers@example.com",
          first_name: "Tom",
          last_name: "Evers",
          phone_numbers: ["1234567890"]
        }
      end

      it "creates or updates the guest" do
        expect { subject }.to change { Guest.count }.by(1)
      end

      it "does not raise any error" do
        expect { subject }.not_to raise_error
      end
    end

    context "with missing guest data" do
      let(:guest_data) { {} }

      it "raises an error" do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "when email is missing in guest data" do
      let(:guest_data) do
        {
          first_name: "Tom",
          last_name: "Evers",
          phone_numbers: ["1234567890"]
        }
      end

      it "raises an error" do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end