RSpec.describe Guest, type: :model do
  subject { Guest.new(email: "test@example.com", first_name: "Test", last_name: "Guest", phone_numbers: ["1234567890"]) }

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
      it do
        subject.email = "invalid email"
        expect(subject).to_not be_valid
        expect(subject.errors[:email]).to include("is invalid")
      end
    end

    context "when email is valid" do
      it do
        subject.email = "valid@example.com"
        expect(subject).to be_valid
      end
    end
  end
end
