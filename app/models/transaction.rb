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
class Transaction < ApplicationRecord
  monetize :amount_cents
  validates :amount_cents, numericality: { greater_than: 0 }
  belongs_to :wallet
end
