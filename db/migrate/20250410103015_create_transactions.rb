class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.string :type
      t.integer :amount_cents
      t.bigint :sender_wallet_id
      t.bigint :receiver_wallet_id

      t.timestamps
    end
  end
end
