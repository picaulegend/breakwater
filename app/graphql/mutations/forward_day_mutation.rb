module Mutations
  class ForwardDayMutation < Mutations::BaseMutation
    field :user, Types::UserType, null: true
    field :errors, Types::ValidationErrorsType, null: true
    field :farm, Types::FarmType, null: true
    field :stack, Types::StackType, null: true
    field :slot, Types::SlotType, null: true

    def resolve()
      check_authentication!

      user = context[:current_user]

      days_played = user.days_played + 1

      farm = Farm.find_by user: user

      stacksIds = []

      Stack.where(farm: farm).find_each do |stack|
        stacksIds.push(stack.id)
      end

      stacksIds.each { |id|
        slot = Slot.find(id)
        if slot.name
          nutrition = slot.nutrition + 1
          slot.update(nutrition: nutrition)
        end
      }

      if user.update(days_played: days_played)
        { user: user }
      else
        { errors: user.errors }
      end
    end
  end
end
