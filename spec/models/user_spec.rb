require 'rails_helper'

RSpec.describe User, type: :model do
  describe "assocations" do
    it { should have_many(:sessions) }
    it { should have_one(:wallet) }
  end

  describe "callbacks" do
    context "after_create" do
      let(:user) { build(:user) }

      it { expect { user.save }.to change(Wallet, :count).by(1) }
      it do
        expect(user.wallet).to be_nil
        user.save
        expect(user.wallet).to be_an_instance_of(Wallet)
      end
    end
  end
end
