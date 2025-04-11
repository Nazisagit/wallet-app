class RenameReceiverWalletIdToRecipientWalletIdOnTransactions < ActiveRecord::Migration[8.0]
  def change
    rename_column :transactions, :receiver_wallet_id, :recipient_wallet_id
  end
end
