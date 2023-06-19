RSpec.describe Reservation, type: :model do

  describe "associations" do
    it { should belong_to(:guest) }
  end

  describe "validations" do
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:nights) }
    it { should validate_presence_of(:payout_price) }
    it { should validate_presence_of(:security_price) }
    it { should validate_presence_of(:total_price) }
    it { should validate_presence_of(:total_number_of_guests) }
    it { should validate_presence_of(:number_of_adults) }
    it { should validate_presence_of(:number_of_children) }
    it { should validate_presence_of(:number_of_infants) }
    it { should validate_presence_of(:source) }
    it { should validate_uniqueness_of(:code) }
  end

end
