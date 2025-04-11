FactoryBot.define do
  factory :transaction do
    wallet
    amount_cents { 1000 }

    factory :deposit, class: "Deposit"
    factory :withdrawal, class: "Withdrawal"
    factory :transfer, class: "Transfer" do
      association :sender_wallet, factory: :wallet
      association :receiver_wallet, factory: :wallet
    end
  end
end
