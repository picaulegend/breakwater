module Mutations
  class SellProductMutation < Mutations::BaseMutation
    argument :product_id, ID, required: true

    field :product, Types::ProductType, null: true
    field :user, Types::UserType, null: true
    field :errors, Types::ValidationErrorsType, null: true

    def resolve(product_id:)
      check_authentication!

      product = Product.find(product_id)
      user = context[:current_user]

      user_money = user.money ? user.money : 0

      money = user.demandCalculation(user_money, product.value)

      product.destroy

      if user.update(money: money)
        { user: user }
      else
        { errors: product.errors }
      end
    end
  end
end
