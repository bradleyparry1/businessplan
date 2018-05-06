class CivilServant < ApplicationRecord
  belongs_to :role
  belongs_to :community
  belongs_to :grade
  belongs_to :profession
  belongs_to :framework
  belongs_to :status
  has_many :base_people, as: :name
  has_many :people, as: :name
  has_many :pchanges, as: :name
end
