class Role < ApplicationRecord
  has_many :names
  belongs_to :account
end
