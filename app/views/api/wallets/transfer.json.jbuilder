json.transaction_id @transfer.id
json.amount         humanized_money_with_symbol(@transfer.amount)
json.recipient do
  json.id             @transfer.recipient.id
  json.email_address  @transfer.recipient.email_address
  json.wallet_id      @transfer.recipient_wallet.id
end
