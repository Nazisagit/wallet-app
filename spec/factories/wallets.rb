FactoryBot.define do
  factory :wallet do
    association :user
    balance_cents { 10000 }
  end
end
