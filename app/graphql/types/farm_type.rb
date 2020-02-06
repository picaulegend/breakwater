module Types
  class FarmType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :stacks, [Types::StackType], null: true
  end
end
