class Person < ApplicationRecord
  has_paper_trail
  belongs_to :name, polymorphic: true
  belongs_to :team
  has_many :pchanges
end
