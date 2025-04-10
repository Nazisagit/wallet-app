module Api
  module V1
    class WalletsController < Api::ApplicationController
      before_action :set_wallet

      def deposit; end
      def withdraw; end
      def transfer; end
      def balance; end
      def transactions; end

      private

      def set_wallet
        @wallet = Wallet.find_by(id: params[:wallet_id])
      end
    end
  end
end
