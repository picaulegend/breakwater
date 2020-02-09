class Item < ApplicationRecord
  belongs_to :store
  has_one :seed
  validates :description, length: { minimum: 10 }, allow_blank: true
end
