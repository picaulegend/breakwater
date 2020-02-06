class Farm < ApplicationRecord
  belongs_to :user
  has_many :stacks
end
