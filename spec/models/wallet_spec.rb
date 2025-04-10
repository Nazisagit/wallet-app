require 'rails_helper'

RSpec.describe Wallet, type: :model do
  describe "assocations" do
    it { should belong_to(:user) }
    it { should have_many(:transactions) }
  end
end
