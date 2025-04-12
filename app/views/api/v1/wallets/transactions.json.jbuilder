json.array! @transactions do |transaction|
  json.transaction_id     transaction.id
  json.transaction_type   transaction.type
  json.amount humanized_money_with_symbol(transaction.amount)
  if transaction.is_a?(Transfer)
    json.recipient transaction.recipient.email_address
  end
end
