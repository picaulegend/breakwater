class Slot < ApplicationRecord
  belongs_to :stack
  has_one :seed
end
