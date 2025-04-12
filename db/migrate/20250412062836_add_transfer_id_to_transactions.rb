class AddTransferIdToTransactions < ActiveRecord::Migration[8.0]
  def change
    add_column :transactions, :transfer_id, :bigint
  end
end
