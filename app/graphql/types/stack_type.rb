module Types
  class StackType < Types::BaseObject
    field :id, ID, null: false
    field :lighting, String, null: false
    field :slots, [Types::SlotType], null: true
  end
end
