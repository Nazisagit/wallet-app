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
class Transaction < ApplicationRecord
  monetize :amount_cents
  validates :amount_cents, numericality: { greater_than: 0 }
end
