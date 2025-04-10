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
  monetize :balance_cents
  belongs_to :user
  has_many :transactions
end
