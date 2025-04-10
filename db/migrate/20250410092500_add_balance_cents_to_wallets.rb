class AddBalanceCentsToWallets < ActiveRecord::Migration[8.0]
  def change
    add_column :wallets, :balance_cents, :integer, default: 0
  end
end
