require 'rails_helper'

RSpec.describe User, type: :model do
  describe "assocations" do
    it { should have_many(:sessions) }
    it { should have_one(:wallet) }
  end
end
