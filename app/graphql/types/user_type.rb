module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :name, String, null: false
    field :farm, Types::FarmType, null: true
    field :store, Types::StoreType, null: true
    field :seeds, [Types::SeedType], null: true
    field :products, [Types::ProductType], null: true
    field :days_played, Int, null: true
    field :money, Int, null: true

    def name
      # `object` references the user instance
      [object.first_name, object.last_name].compact.join(" ")
    end
  end
end
