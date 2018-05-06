class Actual < ApplicationRecord
  belongs_to :team, optional: true
  belongs_to :account, optional: true
end
