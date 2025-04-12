module Api
  class WalletsController < Api::ApplicationController
    rescue_from ArgumentError, StandardError, with: :show_errors
    before_action :set_wallet

    def deposit
      @deposit = DepositService.call(wallet: @wallet, amount: params[:amount])
    end

    def withdraw
      @withdrawal = WithdrawalService.call(wallet: @wallet, amount: params[:amount])
    end

    def transfer
      recipient_wallet = Wallet.find_by(id: params[:recipient_wallet_id])
      @transfer = TransferService.call(sender_wallet: @wallet, recipient_wallet: recipient_wallet, amount: params[:amount])
    end

    def balance; end

    def transactions
      @transactions = @wallet.all_transactions
    end

    private

    def set_wallet
      @wallet = current_user.wallet
    end
  end
end
