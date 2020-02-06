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
  end
end
