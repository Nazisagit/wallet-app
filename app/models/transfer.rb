# == Schema Information
#
# Table name: transactions
#
#  id                 :bigint           not null, primary key
#  amount_cents       :integer
#  type               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  receiver_wallet_id :bigint
#  sender_wallet_id   :bigint
#  wallet_id          :bigint           not null
#
# Indexes
#
#  index_transactions_on_wallet_id  (wallet_id)
#
# Foreign Keys
#
#  fk_rails_...  (wallet_id => wallets.id)
#
class Transfer < Transaction
  belongs_to :sender_wallet, class_name: "Wallet"
  belongs_to :receiver_wallet, class_name: "Wallet"
  validates :sender_wallet_id, :receiver_wallet_id, presence: true
  validates :receiver_wallet_id, comparison: { other_than: :sender_wallet_id }

  def receiver
    receiver_wallet.user
  end
end
