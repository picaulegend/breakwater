class Store < ApplicationRecord
  belongs_to :user
  has_many :items

  def calculateReputation(currentReputation = 0)
    return 1
  end

  def calculatePrice(value = 0, reputation)
    value
  end
end
