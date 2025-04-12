module Api
  module V1
    class WalletsController < Api::ApplicationController
      before_action :set_wallet

      def deposit
        @deposit = DepositService.call(wallet: @wallet, amount: params[:amount])
      end

      def withdraw
        @withdrawal = WithdrawalService.call(wallet: @wallet, amount: params[:amount])
      end

      def transfer
        recipient_wallet = Wallet.find_by(id: transfer_params[:recipient_wallet_id])
        @transfer = TransferService.call(sender_wallet: @wallet, recipient_wallet: recipient_wallet, amount: transfer_params[:amount])
      end
      def balance; end
      def transactions
        @transactions = @wallet.transactions.order(created_at: :desc)
      end

      private

      def set_wallet
        @wallet = Wallet.find_by(id: params[:wallet_id])
      end

      def transfer_params
        params.require(:transfer).permit(:recipient_wallet_id, :amount)
      end
    end
  end
end
