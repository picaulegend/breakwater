class Seed < ApplicationRecord
  belongs_to :slot, optional: true
  belongs_to :user, optional: true
  belongs_to :item, optional: true
end
