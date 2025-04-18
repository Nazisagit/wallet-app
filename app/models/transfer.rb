# == Schema Information
#
# Table name: transactions
#
#  id                  :bigint           not null, primary key
#  amount_cents        :integer
#  type                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  recipient_wallet_id :bigint
#  sender_wallet_id    :bigint
#  transfer_id         :bigint
#  wallet_id           :bigint           not null
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
  belongs_to :recipient_wallet, class_name: "Wallet"
  has_one :withdrawal
  has_one :deposit
  validates :sender_wallet_id, :recipient_wallet_id, presence: true
  validates :recipient_wallet_id, comparison: { other_than: :sender_wallet_id }

  def recipient
    recipient_wallet.user
  end

  def sender
    sender_wallet.user
  end
end
