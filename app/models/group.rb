class Group < ApplicationRecord
  has_many :teams
  has_many :permissions
  has_many :users, through: :permissions
end
