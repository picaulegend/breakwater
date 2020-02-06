class User < ApplicationRecord
  has_many :items, dependent: :destroy
  has_one :farm, dependent: :destroy
  has_many :seeds, dependent: :destroy
  has_many :products, dependent: :destroy
end
