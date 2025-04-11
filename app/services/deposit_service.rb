class DepositService < ApplicationService
  def initialize(wallet:, amount:)
    @wallet = wallet
    @amount = amount.to_f
  end

  def call
    ApplicationRecord.transaction do
      raise ArgumentError, "Amount cannot be a zero or negative value" if amount.zero? || amount.negative?
      raise ArgumentError, "A valid wallet was not provided" unless wallet.is_a?(Wallet)
      deposit = Deposit.create!(wallet: wallet, amount: amount)
      new_balance = wallet.balance + deposit.amount
      wallet.update(balance: new_balance)
    end
    wallet
  end

  private

  attr_accessor :wallet, :amount
end
