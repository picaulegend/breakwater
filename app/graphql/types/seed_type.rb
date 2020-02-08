module Types
  class SeedType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :produce_type, ProduceTypes, null: true
    field :longevity, Integer, null: false
    field :health, Integer, null: false
    field :nutrition, Integer, null: false
    field :days_required, Integer, null: false
    field :value, Integer, null: true
  end
end
