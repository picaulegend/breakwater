module Types
  class QueryType < Types::BaseObject
    field :items,
          [Types::ItemType],
          null: false,
          description: "Returns a list of items"

    def items
      Item.preload(:user)
    end

    field :user, Types::UserType, null: true

    def user
      context[:current_user]
    end
  end
end
