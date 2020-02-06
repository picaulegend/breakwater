module Mutations
  class SeedSlotMutation < Mutations::BaseMutation
    argument :seed_id, ID, required: true
    argument :slot_id, ID, required: true

    field :seed, Types::SeedType, null: true
    field :slot, Types::SlotType, null: true
    field :errors, Types::ValidationErrorsType, null: true

    def resolve(seed_id:, slot_id:)
      #   check_authentication!

      seed = Seed.find(seed_id)
      puts seed.produce_type
      # update the slot
      slot = Slot.find(slot_id)

      size = 3 # needs to be calculated somehow

      produce_type = seed.produce_type ? seed.produce_type : "STONE_FRUIT"
      day_of_seeding = 3 # needs to be queried from current_user
      days_required = seed.days_required ? seed.days_required : 5

      if slot.update(name: seed.name, produce_type: produce_type, nutrition: seed.nutrition, health: seed.health, longevity: seed.longevity, size: 3, days_required: days_required, day_of_seeding: day_of_seeding)
        { slot: slot }
      else
        { errors: item.errors }
      end
    end
  end
end

# field :name, String, null: false
# field :produce_type, ProduceTypes, null: false
# field :nutrition, Integer, null: false
# field :health, Integer, null: false
# field :longevity, Integer, null: false
# field :size, Integer, null: false
# field :days_required, Integer, null: false
# field :day_of_seeding, Integer, null: false
