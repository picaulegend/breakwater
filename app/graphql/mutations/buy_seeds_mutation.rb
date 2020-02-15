module Mutations
  class BuySeedsMutation < Mutations::BaseMutation
    argument :item_id, ID, required: true
    argument :amount, Float, required: false
    argument :custom_price, Float, required: false

    field :user, Types::UserType, null: true
    field :seed, Types::SeedType, null: true
    field :item, Types::ItemType, null: true
    field :store, Types::StoreType, null: true
    field :errors, Types::ValidationErrorsType, null: true

    def resolve(item_id:, amount:, custom_price:)
      check_authentication!

      item = Item.find(item_id)
      store = item.store
      user = context[:current_user]
      seed = item.seed
      reputation = store.calculateReputation(store.reputation)
      stock = item.amount_in_stock ? item.amount_in_stock : 0

      amount_needed = amount ? amount - 1 : 0

      if stock > amount_needed
        cost = store.calculatePrice(seed.value, reputation, custom_price)
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
        { errors: { "details" => "Not in stock" } }
      end
    end
  end
end
