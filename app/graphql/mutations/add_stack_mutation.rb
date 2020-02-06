module Mutations
  class AddStackMutation < Mutations::BaseMutation
    argument :lighting, String, required: true
    argument :farm_id, ID, required: true

    field :stack, Types::StackType, null: true
    field :farm, Types::FarmType, null: true
    field :errors, Types::ValidationErrorsType, null: true

    def resolve(lighting:, farm_id:)
      check_authentication!

      farm = Farm.find(farm_id)

      stack = Stack.new(
        lighting: lighting,
        farm: farm,
      )

      if stack.save
        { stack: stack }
      else
        { errors: stack.errors }
      end
    end
  end
end
