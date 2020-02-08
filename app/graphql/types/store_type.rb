module Types
  class StoreType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :user, Types::UserType, null: false
    field :seeds, [Types::SeedType], null: true
  end
end
