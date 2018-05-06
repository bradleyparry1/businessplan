class Pchange < ApplicationRecord
  belongs_to :person, optional: true
  belongs_to :name, polymorphic: true
  belongs_to :team
  belongs_to :user
end
