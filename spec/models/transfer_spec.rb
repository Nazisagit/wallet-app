require 'rails_helper'

RSpec.describe Transfer, type: :model do
  describe "associations" do
    it { should belong_to(:sender_wallet) }
    it { should belong_to(:receiver_wallet) }
  end

  describe "validations" do
    it { should validate_presence_of(:sender_wallet_id) }
    it { should validate_presence_of(:receiver_wallet_id) }
  end
end
