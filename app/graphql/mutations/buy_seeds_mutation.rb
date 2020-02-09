module Mutations
  class BuySeedsMutation < Mutations::BaseMutation
    argument :item_id, ID, required: true

    field :user, Types::UserType, null: true
    field :seed, Types::SeedType, null: true
    field :item, Types::ItemType, null: true
    field :store, Types::StoreType, null: true
    field :errors, Types::ValidationErrorsType, null: true

    def resolve(item_id:)
      check_authentication!

      item = Item.find(item_id)
      store = item.store
      user = context[:current_user]
      seed = item.seed
      reputation = store.calculateReputation(store.reputation)
      stock = item.amount_in_stock ? item.amount_in_stock : 0

      if stock > 0
        cost = store.calculatePrice(seed.value, reputation)
        money = user.money ? user.money : 0

        if money > cost
          newMoney = money - cost
          user.update(money: newMoney)
          store.update(reputation: reputation)

          newAmount = stock - 1

          Seed.create(
            user: user,
            name: seed.name,
            produce_type: seed.produce_type,
            longevity: seed.longevity,
            health: seed.health,
            nutrition: seed.nutrition,
            days_required: seed.days_required,
            value: seed.value,
          )

          if item.update(amount_in_stock: newAmount)
            { user: user }
          else
            { errors: stack.errors }
          end
        else
          raise "Not enough money"
        end
      else
        raise "Not in stock"
      end
    end
  end
end
