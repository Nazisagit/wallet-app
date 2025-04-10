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
#
class Transfer < Transaction
  belongs_to :sender_wallet, class_name: "Wallet"
  belongs_to :receiver_wallet, class_name: "Wallet"
  validates :sender_wallet_id, :receiver_wallet_id, presence: true
  validates :receiver_wallet_id, comparison: { other_than: :sender_wallet_id }
end
