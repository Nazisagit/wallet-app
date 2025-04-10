class AddWalletReferenceToTransactions < ActiveRecord::Migration[8.0]
  def change
    add_reference :transactions, :wallet, null: false, foreign_key: true
  end
end
