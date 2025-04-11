module Api
  module V1
    class WalletsController < Api::ApplicationController
      before_action :set_wallet

      def deposit
        @wallet = DepositService.call(wallet: @wallet, amount: params[:amount])
      end
      def withdraw; end
      def transfer; end
      def balance; end
      def transactions
        @transactions = @wallet.transactions.order(created_at: :desc)
      end

      private

      def set_wallet
        @wallet = Wallet.find_by(id: params[:wallet_id])
      end
    end
  end
end
