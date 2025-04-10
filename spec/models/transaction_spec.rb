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
require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "validations" do
    it { should validate_numericality_of(:amount_cents) }
  end
end
