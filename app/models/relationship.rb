class Relationship < ApplicationRecord
  belongs_to :party, polymorphic: true
  belongs_to :resource, polymorphic: true
  belongs_to :creator, polymorphic: true, optional: true
end
