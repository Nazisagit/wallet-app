require 'rails_helper'

RSpec.describe "WithdrawalService", type: :service do
  subject { WithdrawalService }

  describe "#call" do
    let!(:user) { create(:user) }

    context "when the wallet has a starting balance of $100" do
      let!(:wallet) { create(:wallet, user: user) }

      context "when withdrawing $50" do
        let(:amount) { 50 }

        it "creates a new Deposit" do
          expect {
            subject.call(wallet: wallet, amount: amount)
          }.to change(Withdrawal, :count).by(1)
        end

        it "it decreases the wallet balance" do
          subject.call(wallet: wallet, amount: amount)
          expect(wallet.balance.to_s).to eq("50.00")
        end

        it "returns a Withdrawal object" do
          expect(subject.call(wallet: wallet, amount: amount)).to be_an_instance_of(Withdrawal)
        end
      end

      context "when withdrawing $50.50" do
        let(:amount) { 50.50 }

        it "creates a new Withdrawal" do
          expect {
            subject.call(wallet: wallet, amount: amount)
          }.to change(Withdrawal, :count).by(1)
        end

        it "it increases the wallet balance" do
          subject.call(wallet: wallet, amount: amount)
          expect(wallet.balance.to_s).to eq("49.50")
        end
      end

      context "when withdrawing in excess of $100" do
        let(:amount) { 150 }

        it do
          expect {
            subject.call(wallet: wallet, amount: amount)
          }.to change(Withdrawal, :count).by(0)
          .and raise_error(StandardError, "Wallet does not hold enough funds")
        end
      end

      context "when depositing a negative amount" do
        let(:amount) { -50 }

        it "raises an error" do
          expect {
            subject.call(wallet: wallet, amount: amount)
          }.to change(Withdrawal, :count).by(0)
          .and raise_error(ArgumentError, "Amount cannot be a zero or negative value")
        end
      end

      context "when depositing a non-number" do
        let(:amount) { "brrr" }

        it "raises an error" do
          expect {
            subject.call(wallet: wallet, amount: amount)
          }.to change(Withdrawal, :count).by(0)
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
        }.to change(Withdrawal, :count).by(0)
        .and raise_error(ArgumentError, "A valid wallet was not provided")
      end
    end
  end
end
