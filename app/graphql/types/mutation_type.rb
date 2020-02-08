module Types
  class MutationType < Types::BaseObject
    field :sign_in, mutation: Mutations::SignInMutation
    field :add_item, mutation: Mutations::AddItemMutation
    field :update_item, mutation: Mutations::UpdateItemMutation
    field :add_stack, mutation: Mutations::AddStackMutation
    field :add_slot, mutation: Mutations::AddSlotMutation
    field :seed_slot, mutation: Mutations::SeedSlotMutation
    field :reap_slot, mutation: Mutations::ReapSlotMutation
    field :sell_product, mutation: Mutations::SellProductMutation
    field :buy_seeds, mutation: Mutations::BuySeedsMutation
  end
end
