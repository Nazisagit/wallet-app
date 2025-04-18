# == Schema Information
#
# Table name: wallets
#
#  id            :bigint           not null, primary key
#  balance_cents :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_wallets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Wallet < ApplicationRecord
  monetize :balance_cents, numericality: { greater_than_or_equal_to: 0 }
  belongs_to :user
  has_many :transactions, dependent: :destroy

  def all_transactions
    Transaction
      .where("(wallet_id = :id) OR (type = 'Transfer' AND (sender_wallet_id = :id OR recipient_wallet_id = :id))", id: self.id)
      .order(created_at: :desc)
  end
end
