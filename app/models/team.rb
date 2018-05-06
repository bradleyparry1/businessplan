class Team < ApplicationRecord
  belongs_to :group
  belongs_to :programme
  has_many :base_people
  has_many :base_others
  has_many :people
  has_many :pchanges
  has_many :others
  has_many :ochanges
end
