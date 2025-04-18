require 'rails_helper'

RSpec.describe Transfer, type: :model do
  describe "associations" do
    it { should belong_to(:sender_wallet) }
    it { should belong_to(:recipient_wallet) }
  end

  describe "validations" do
    it { should validate_presence_of(:sender_wallet_id) }
    it { should validate_presence_of(:recipient_wallet_id) }

    context "when sender_wallet_id and recipient_wallet_id are present" do
      subject { build(:transfer, recipient_wallet_id: 1, sender_wallet_id: 2) }
      it { should validate_comparison_of(:recipient_wallet_id).is_other_than(:sender_wallet_id) }
    end
  end
end
