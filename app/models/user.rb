# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  auth_token      :string
#  email_address   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_auth_token     (auth_token) UNIQUE
#  index_users_on_email_address  (email_address) UNIQUE
#
class User < ApplicationRecord
  has_secure_password
  has_secure_token :auth_token
  has_many :sessions, dependent: :destroy
  has_one :wallet, dependent: :destroy
  after_create :create_wallet

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
