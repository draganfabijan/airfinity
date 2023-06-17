RSpec.describe Guest, type: :model do

  describe "associations" do
    it { should have_many(:reservations) }
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:phone_numbers) }
    it { should validate_uniqueness_of(:email) }

    context "when email is invalid" do
      let(:guest) { FactoryBot.build(:guest, email: "invalid email") }
      it do
        expect(guest).to_not be_valid
        expect(guest.errors[:email]).to include("is invalid")
      end
    end

    context "when email is valid" do
      let(:guest) { FactoryBot.build(:guest, email: "rodeo@gmail.com") }

      it { expect(guest).to be_valid }
    end
  end
end
