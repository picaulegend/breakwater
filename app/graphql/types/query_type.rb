module Types
  class QueryType < Types::BaseObject
    field :items,
          [Types::ItemType],
          null: false,
          description: "Returns a list of items"

    def items
      Item.preload(:user)
    end

    field :user, Types::UserType, null: true do
      description "Find session user or a user by ID"
      argument :id, ID, required: false
    end

    def user(id: nil)
      if id
        User.find(id)
      else
        context[:current_user]
      end
    end

    field :farm, Types::FarmType, null: true do
      description "Find a farm by ID"
      argument :id, ID, required: false
    end

    def farm(id: nil)
      Farm.find(id)
    end

    field :store, Types::StoreType, null: true do
      description "Find a store by ID"
      argument :id, ID, required: false
    end

    def store(id: nil)
      Store.find(id)
    end
  end
end
