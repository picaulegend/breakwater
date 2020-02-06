class Stack < ApplicationRecord
  belongs_to :farm
  has_many :slots
end
