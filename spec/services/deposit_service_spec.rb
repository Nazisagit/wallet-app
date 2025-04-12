require 'rails_helper'

RSpec.describe "DepositService", type: :service do
  subject { DepositService }

  describe "#call" do
    let!(:user) { create(:user) }

    context "when the wallet has a starting balance of $100" do
      let!(:wallet) { create(:wallet, user: user) }

      context "when depositing $50" do
        let(:amount) { 50 }

        it "creates a new Deposit" do
          expect {
            subject.call(wallet: wallet, amount: amount)
          }.to change(Deposit, :count).by(1)
        end

        it "it increases the wallet balance" do
          subject.call(wallet: wallet, amount: amount)
          expect(wallet.balance.to_s).to eq("150.00")
        end

        it "returns a Deposit object" do
          expect(subject.call(wallet: wallet, amount: amount)).to be_an_instance_of(Deposit)
        end
      end

      context "when depositing $50.50" do
        let(:amount) { 50.50 }

        it "creates a new Deposit" do
          expect {
            subject.call(wallet: wallet, amount: amount)
          }.to change(Deposit, :count).by(1)
        end

        it "it increases the wallet balance" do
          subject.call(wallet: wallet, amount: amount)
          expect(wallet.balance.to_s).to eq("150.50")
        end
      end

      context "when depositing a negative amount" do
        let(:amount) { -50 }

        it "raises an error" do
          expect {
            subject.call(wallet: wallet, amount: amount)
          }.to change(Deposit, :count).by(0)
          .and raise_error(ArgumentError, "Amount cannot be a zero or negative value")
        end
      end

      context "when depositing a non-number" do
        let(:amount) { "brrr" }

        it "raises an error" do
          expect {
            subject.call(wallet: wallet, amount: amount)
          }.to change(Deposit, :count).by(0)
          .and raise_error(ArgumentError, "Amount cannot be a zero or negative value")
        end
      end
    end

    context "when a non-Wallet object is provided" do
      let(:wallet) { nil }
      let(:amount) { 50 }

      it "raises an error" do
        expect {
          subject.call(wallet: wallet, amount: amount)
        }.to change(Deposit, :count).by(0)
        .and raise_error(ArgumentError, "A valid wallet was not provided")
      end
    end
  end
end
