require 'rails_helper'

RSpec.describe "Api::Wallets", type: :request do
  let!(:user) { create(:user) }

  describe "PUT /deposit" do
    before { login }
    context "when given a valid wallet and amount" do
      let(:amount) { 50 }

      it "returns the previous balance and new balance" do
        put deposit_api_wallet_path, params: { amount: amount }, headers: headers
        expect(response.status).to eq(200)
        expect(json["previous_balance"]).to eq("$0")
        expect(json["new_balance"]).to eq("$50")
      end
    end
  end

  describe "PUT /withdraw" do
    before do
      login
      user.wallet.update(balance: 100)
    end
    after { user.wallet.update(balance: 0) }
    context "when given a valid wallet and amount" do
      let(:amount) { 50 }

      it "returns the previous balance and new balance" do
        put withdraw_api_wallet_path, params: { amount: amount }, headers: headers

        expect(response.status).to eq(200)
        expect(json["previous_balance"]).to eq("$100")
        expect(json["new_balance"]).to eq("$50")
      end
    end
  end

  describe "PUT /transfer" do
    before do
      login
      user.wallet.update(balance: 100)
    end
    after { user.wallet.update(balance: 0) }
    let(:transfer_params) do
      {
        recipient_wallet_id: recipient.wallet.id,
        amount: amount
      }
    end

    context "when the sender and recipient are valid" do
      let!(:recipient) { create(:user) }
      let(:amount) { 50 }

      it "returns the transfer information" do
        put transfer_api_wallet_path, params: transfer_params, headers: headers
        expect(response.status).to eq(200)
        expect(json["amount"]).to eq("$#{amount}")
        expect(json["recipient"]["id"]).to eq(recipient.id)
        expect(json["recipient"]["wallet_id"]).to eq(recipient.wallet.id)
      end
    end
  end

  describe "GET /balance" do
    before { login }
    context "when the balance is a round number" do
      it "should return the balance without cents" do
        user.wallet.update(balance: 100)
        get balance_api_wallet_path, headers: headers
        expect(response.status).to eq(200)
        expect(json["balance"]).to eq("$100")
      end
    end

    context "when the balance has cents" do
      it "should return the balance without cents" do
        user.wallet.update(balance: 100.50)
        get balance_api_wallet_path, headers: headers
        expect(response.status).to eq(200)
        expect(json["balance"]).to eq("$100.50")
      end
    end
  end

  describe "GET /transactions" do
    before { login }
    context "when there are no transactions" do
      it "should return an empty array" do
        get transactions_api_wallet_path, headers: headers
        expect(response.status).to eq(200)
        expect(json).to eq([])
      end
    end

    context "when there are transactions" do
      let!(:deposit) { create(:deposit, wallet: user.wallet) }
      let!(:withdrawal) { create(:withdrawal, wallet: user.wallet) }
      let!(:recipient) { create(:user) }
      let!(:transfer) { create(:transfer, wallet: user.wallet, sender_wallet: user.wallet, recipient_wallet: recipient.wallet) }

      it "should return an array of transactions ordered newest to oldest" do
        get transactions_api_wallet_path, headers: headers
        expect(response.status).to eq(200)
        expect(json.size).to eq(3)
      end
    end
  end
end
