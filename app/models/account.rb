class Account < ApplicationRecord
  has_many :others
  has_many :actuals
  has_many :roles
  has_many :base_others
end
