class TransferService < ApplicationService
  def initialize(sender_wallet:, recipient_wallet:, amount:)
    @sender_wallet = sender_wallet
    @recipient_wallet = recipient_wallet
    @amount = amount.to_f
  end

  def call
    ApplicationRecord.transaction do
      withdrawal = WithdrawalService.call(wallet: sender_wallet, amount: amount)
      deposit = DepositService.call(wallet: recipient_wallet, amount: amount)
      Transfer.create!(
        wallet: sender_wallet,
        sender_wallet: sender_wallet,
        recipient_wallet: recipient_wallet,
        withdrawal: withdrawal,
        deposit: deposit,
        amount: amount)
    end
  end

  private

  attr_accessor :sender_wallet, :recipient_wallet, :amount
end
