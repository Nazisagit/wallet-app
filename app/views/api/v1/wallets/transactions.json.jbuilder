json.array! @transactions do |transaction|
  json.id     transaction.id
  json.type   transaction.type
  json.amount humanized_money_with_symbol(transaction.amount)
  if transaction.is_a?(Transfer)
    json.recipient transaction.recipient.email_address
  end
end
