class Account < ApplicationRecord
  has_many :others
  has_many :actuals
  has_many :roles
end
