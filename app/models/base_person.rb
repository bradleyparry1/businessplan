class BasePerson < ApplicationRecord
  belongs_to :name, polymorphic: true
  belongs_to :team
end
