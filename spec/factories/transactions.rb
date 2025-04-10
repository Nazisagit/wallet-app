FactoryBot.define do
  factory :transaction do
    type { "" }
    amount_cents { 1 }
    sender { nil }
    receiver { nil }
  end
end
