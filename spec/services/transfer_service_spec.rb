require 'rails_helper'

RSpec.describe "TransferService", type: :service do
  subject { TransferService }

  describe "#call" do
  let!(:sender) { create(:user) }
  let!(:recipient) { create(:user) }
  let(:service_call) do
    subject.call(sender_wallet: sender_wallet, recipient_wallet: recipient_wallet, amount: amount)
  end

    context "when the sender has enough funds" do
      let!(:sender_wallet) { create(:wallet, user: sender) }
      let!(:recipient_wallet) { create(:wallet, user: recipient) }
      let(:amount) { 50 }

      it do
        expect {
          service_call
        }.to change(Withdrawal, :count).by(1)
        .and change(Deposit, :count).by(1)
        .and change(Transfer, :count).by(1)
      end

      it { expect(service_call).to be_an_instance_of(Transfer) }

      it do
        transfer = service_call
        withdrawal = transfer.withdrawal
        expect(withdrawal.wallet).to eq(sender_wallet)
        expect(withdrawal.amount.to_i).to eq(amount)
        expect(withdrawal.wallet).to eq(sender_wallet)
        expect(withdrawal.transfer_id).to eq(transfer.id)
      end

      it do
        transfer = service_call
        deposit = transfer.deposit
        expect(deposit.wallet).to eq(recipient_wallet)
        expect(deposit.amount.to_i).to eq(amount)
        expect(deposit.wallet).to eq(recipient_wallet)
        expect(deposit.transfer_id).to eq(transfer.id)
      end

      it do
        transfer = service_call
        expect(transfer.wallet).to eq(sender_wallet)
        expect(transfer.sender).to eq(sender)
        expect(transfer.sender_wallet).to eq(sender_wallet)
        expect(transfer.recipient).to eq(recipient)
        expect(transfer.recipient_wallet).to eq(recipient_wallet)
        expect(transfer.amount.to_i).to eq(amount)
      end
    end

    context "when the sender wallet has insufficient funds" do
      let!(:sender_wallet) { create(:wallet, user: sender, balance: 25) }
      let!(:recipient_wallet) { create(:wallet, user: recipient) }
      let(:amount) { 50 }

      it do
        expect {
          service_call
      }.to change(Withdrawal, :count).by(0)
      .and change(Deposit, :count).by(0)
      .and change(Transfer, :count).by(0)
      .and raise_error(StandardError, "Wallet does not hold enough funds")
      end
    end
  end
end
