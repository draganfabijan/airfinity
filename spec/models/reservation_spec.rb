RSpec.describe Reservation, type: :model do

  describe "associations" do
    it { should belong_to(:guest) }
  end

  describe "validations" do
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_uniqueness_of(:code) }
  end

end
