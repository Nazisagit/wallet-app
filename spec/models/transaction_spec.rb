require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "associations" do
    it { should belong_to(:wallet) }
  end

  describe "validations" do
    it { should validate_numericality_of(:amount_cents) }
  end
end
