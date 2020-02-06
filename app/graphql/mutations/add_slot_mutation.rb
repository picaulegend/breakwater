module Mutations
  class AddSlotMutation < Mutations::BaseMutation
    argument :stack_id, ID, required: true

    field :stack, Types::StackType, null: true
    field :slot, Types::SlotType, null: true
    field :errors, Types::ValidationErrorsType, null: true

    def resolve(stack_id:)
      check_authentication!

      stack = Stack.find(stack_id)

      slot = Slot.new(
        stack: stack,
      )

      if slot.save
        { slot: slot }
      else
        { errors: slot.errors }
      end
    end
  end
end
