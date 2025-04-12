# README

## Design decisions

### Model design

Utilised Rails STI to model `Withdrawal`, `Deposit`, and `Transfer` as types of `Transaction`.
This keeps all relevant information in one table making queries simple.

```ruby
class Transaction; end
class Withdrawal < Transaction; end
class Deposit < Transaction; end
class Transfer < Transaction; end
```

### Controller and route design

Created a separate namespace (`api`) with default `json` formatting. All operations (`deposit`, `withdraw`, `transfer`, `balance`, `transactions`) for wallets fall under a single controller.

```ruby
module Api
  class WalletsController < Api::ApplicationController
    def deposit; end
    def withdraw; end
    def transfer; end
    def balance; end
    def transactions; end
  end
end
```

### Authentication

Utilised Rails 8 built-in password and token authentication.

## How to setup and run the app

### Requirements

* Ruby version: 3.4.2

* Rails version: 8.0.2

* Yarn version: 4.8.1

### Instructions

1. Clone the repo

2. Ensure the above ruby and [yarn](https://yarnpkg.com/migration/guide) versions have been installed and enabled

3. Run `bundle install` to install all necessary gems

4. Run `yarn install` after following the link above to ensure that the app has been migrated over

5. Start the server `rails s`

## How to review my code

In order:

1. Model and model specs. Focus on the `Transaction` models

2. Service and service specs

3. Controller and controller specs
