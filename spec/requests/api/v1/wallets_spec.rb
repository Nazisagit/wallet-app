require 'rails_helper'

RSpec.describe "Api::V1::Wallets", type: :request do
  let!(:user) { create(:user) }

  describe "PUT /deposit" do
    context "when given a valid wallet and amount" do
      let!(:wallet) { create(:wallet, user: user) }
      let(:amount) { 50 }

      it "returns the previous balance and new balance" do
        put api_v1_wallet_deposit_path(wallet_id: wallet.id), params: { amount: amount }

        expect(response.status).to eq(200)
        expect(json["previous_balance"]).to eq("$100")
        expect(json["new_balance"]).to eq("$150")
      end
    end
  end

  describe "PUT /withdraw" do
    context "when given a valid wallet and amount" do
      let!(:wallet) { create(:wallet, user: user) }
      let(:amount) { 50 }

      it "returns the previous balance and new balance" do
        put api_v1_wallet_withdraw_path(wallet_id: wallet.id), params: { amount: amount }

        expect(response.status).to eq(200)
        expect(json["previous_balance"]).to eq("$100")
        expect(json["new_balance"]).to eq("$50")
      end
    end
  end

  describe "PUT /transfer" do
  end

  describe "GET /balance" do
    before do
      get api_v1_wallet_balance_path(wallet_id: wallet.id)
    end

    context "when the balance is a round number" do
      let(:wallet) { create(:wallet, user: user) }

      it "should return the balance without cents" do
        expect(response.status).to eq(200)
        expect(json["balance"]).to eq("$100")
      end
    end

    context "when the balance has cents" do
      let(:wallet) { create(:wallet, user: user, balance_cents: 10050) }

      it "should return the balance without cents" do
        expect(response.status).to eq(200)
        expect(json["balance"]).to eq("$100.50")
      end
    end
  end

  describe "GET /transactions" do
    let!(:wallet) { create(:wallet, user: user) }

    context "when there are no transactions" do
      it "should return an empty array" do
        get api_v1_wallet_transactions_path(wallet_id: wallet.id)

        expect(response.status).to eq(200)
        expect(json).to eq([])
      end
    end

    context "when there are transactions" do
      let!(:deposit) { create(:deposit, wallet: wallet) }
      let!(:withdrawal) { create(:withdrawal, wallet: wallet) }
      let!(:transfer) { create(:transfer, wallet: wallet, sender_wallet: wallet, recipient_wallet: create(:wallet)) }

      it "should return an array of transactions ordered newest to oldest" do
        get api_v1_wallet_transactions_path(wallet_id: wallet.id)

        expect(response.status).to eq(200)
        expect(json.size).to eq(3)
      end
    end
  end
end
