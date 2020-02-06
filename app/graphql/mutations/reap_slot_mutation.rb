module Mutations
  class ReapSlotMutation < Mutations::BaseMutation
    argument :slot_id, ID, required: true

    field :slot, Types::SlotType, null: true
    field :product, Types::ProductType, null: true
    field :user, Types::UserType, null: true
    field :errors, Types::ValidationErrorsType, null: true

    def resolve(slot_id:)
      check_authentication!

      slot = Slot.find(slot_id)
      user = context[:current_user]

      current_day = user.days_played

      # create a product
      name = slot.name
      produce_type = slot.produce_type
      value = 30 # calculated via demand system

      # based on day of reaping (too late, will diminish quality, correct day will give boost)
      nutrition = slot.nutrition
      health = slot.health
      longevity = slot.longevity
      size = slot.size

      product = Product.new(
        name: name,
        produce_type: produce_type,
        value: value,
        nutrition: nutrition,
        health: health,
        longevity: longevity,
        size: size,
        user: user,
      )

      if product.save
        { product: product }
      else
        { errors: product.errors }
      end
    end
  end
end
