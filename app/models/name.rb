class Name < ApplicationRecord
  belongs_to :role
  belongs_to :community
  belongs_to :grade
  belongs_to :profession
  belongs_to :framework
  belongs_to :status
  has_many :base_people
  has_many :people
  has_many :pchanges
end
