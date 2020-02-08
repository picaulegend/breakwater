class User < ApplicationRecord
  has_many :items, dependent: :destroy
  has_one :farm, dependent: :destroy
  has_one :store, dependent: :destroy
  has_many :seeds, dependent: :destroy
  has_many :products, dependent: :destroy

  def demandCalculation(userMoney, productValue)
    # come up with a demand system

    userMoney + productValue + 500
  end
end
