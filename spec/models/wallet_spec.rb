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
require 'rails_helper'

RSpec.describe Wallet, type: :model do
  describe "assocations" do
    it { should belong_to(:user) }
  end
end
