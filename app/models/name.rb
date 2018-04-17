class Name < ApplicationRecord
  has_paper_trail
  belongs_to :role
  belongs_to :community
  belongs_to :grade
  belongs_to :profession
  belongs_to :framework
  belongs_to :status
  has_many :people
  has_many :pchanges
end
