module Types
  class SlotType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :produce_type, ProduceTypes, null: false
    field :nutrition, Integer, null: false
    field :health, Integer, null: false
    field :longevity, Integer, null: false
    field :size, Integer, null: false
    field :days_required, Integer, null: false
    field :day_of_seeding, Integer, null: false

    field :seed, Types::SeedType, null: true
  end
end

# health
# nutrition
# longevity
# size
# type
# days_required
# day_of_seeding
# name

# demand:
# healthy 0/5           do people care about their health
# nutriciousness 0/5    do people need to fill their belly, b/c of low food quantity, or do they eat just for taste/snack
# longevity 0/5         do people need to save their food for longer periods of times
# rarity 0/5            do people want exotic stuff for status

# product:
# name: ""
# cost: Int              this is a calculated number based on cost of seed and costs of production, used only for informational purposes
# price: Int             this is the price that you give the product
# value: Int             this is the inherent worth of your product times demand

# healthy 0/5
# nutriciousness 0/5
# longevity 0/5
# rarity 0/5

## demand scores are randomly generated each day of the year
## value is the match between demand & product.

# type has a base value, based on random demand, it will be higher or lower
# high health, nutrition, longevity scores -> raise the value
