RSpec.describe "Api::V1::Reservations", type: :request do
  describe "POST /create" do
    it "returns http success" do
      get "/api/v1/reservations"
      expect(response).to have_http_status(:success)
    end
  end
end