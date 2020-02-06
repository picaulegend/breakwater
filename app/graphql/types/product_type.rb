module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :produce_type, ProduceTypes, null: false
    field :value, Integer, null: false
    field :nutrition, Integer, null: false
    field :health, Integer, null: false
    field :longevity, Integer, null: false
    field :size, Integer, null: false
  end
end
