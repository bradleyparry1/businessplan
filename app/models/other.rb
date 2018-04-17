class Other < ApplicationRecord
  has_paper_trail
  belongs_to :team
  belongs_to :account
end
