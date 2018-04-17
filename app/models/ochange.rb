class Ochange < ApplicationRecord
  belongs_to :team
  belongs_to :account
  belongs_to :user
end
