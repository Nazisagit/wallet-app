require 'rails_helper'

RSpec.describe "Api::Sessions", type: :request do
  describe "POST /" do
    context "with a valid user" do
      let!(:user) { create(:user) }
      it do
        post api_sessions_path, params: { email_address: user.email_address, password: user.password }
        expect(response.status).to eq(200)
        expect(json["token"]).to_not be_nil
      end
    end

    context "with a non-valid user" do
      let(:user) { double(email_address: Faker::Internet.email, password: Faker::Internet.password) }
      it do
        post api_sessions_path, params: { email_address: user.email_address, password: user.password }
        expect(response.status).to eq(401)
        expect(json["error"]).to eq("Invalid email or password")
      end
    end
  end
end
