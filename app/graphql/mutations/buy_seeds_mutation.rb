module Mutations
  class BuySeedsMutation < Mutations::BaseMutation
    argument :seed_id, ID, required: true

    field :user, Types::UserType, null: true
    field :seed, Types::SeedType, null: true
    field :errors, Types::ValidationErrorsType, null: true

    def resolve(seed_id:)
      check_authentication!

      seed = Seed.find(seed_id)
      user = context[:current_user]

      cost = seed.value ? seed.value : 0
      money = user.money ? user.money : 0

      puts cost
      puts money

      if money > cost
        if seed.update(user: user, store: nil)
          { seed: seed }
        else
          { errors: stack.errors }
        end
        newMoney = money - value
        user.update(money: newMoney)
      else
        { errors: "not enough money" }
      end
    end
  end
end
