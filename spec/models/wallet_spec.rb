require 'rails_helper'

RSpec.describe Wallet, type: :model do
  describe "assocations" do
    it { should belong_to(:user) }
    it { should have_many(:transactions) }
  end

  describe "transactions" do
    let!(:user) { create(:user) }
    let!(:wallet) { create(:wallet, user: user) }
    let!(:deposit) { create(:deposit, wallet: wallet) }
    let!(:withdrawal) { create(:withdrawal, wallet: wallet) }
    let!(:transfer) { create(:transfer, wallet: wallet, sender_wallet: wallet, recipient_wallet: create(:wallet)) }

    it "should hold different types of transactions" do
      expect(wallet.transactions.size).to eq(3)
      expect(wallet.transactions).to include(deposit, withdrawal, transfer)
    end
  end
end
