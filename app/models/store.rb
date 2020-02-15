class Store < ApplicationRecord
  belongs_to :user
  has_many :items

  def calculateReputation(currentReputation = 0)
    # a big purchase gives you a reputation point

    return 1
  end

  def calculatePrice(value = 0, reputation, custom_price)
    # many seeds at once, gives discount
    # a good reputation gives you a discount
    # a bad reputation raise the price

    # if custom price
    # the store will only accept a lower price if it's within the boundaries based on reputation
    # if the price is not acceptable, rejection is returned
    # if the price is an offense, reputation points are deducted

    if reputation > 0
      value * 0.95
    else
      value * 1.05
    end
  end
end
