module Types
  class ItemType < Types::BaseObject
    field :id, ID, null: false
    field :description, String, null: true
    field :amount_in_stock, Integer, null: true
    field :price, Integer, null: true
    field :seed, Types::SeedType, null: true

    def price
      object.store.calculatePrice(object.seed.value, object.store.reputation)
    end
  end
end
