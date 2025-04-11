json.previous_balance humanized_money_with_symbol(Money.new(@wallet.balance_cents_previously_was))
json.new_balance      humanized_money_with_symbol(@wallet.balance)
