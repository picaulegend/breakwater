module Mutations
  class BuySeedsMutation < Mutations::BaseMutation
    argument :name, String, required: true
    argument :type, String, required: true

    field :user, Types::UserType, null: true
    field :seed, Types::SeedType, null: true
    field :errors, Types::ValidationErrorsType, null: true

    # WIP!!!!

    def resolve(name:, type:)
      check_authentication!

      user = context[:current_user]

      seed = Seed.new(
        name: name,
        produce_type: type,
        user: user,
      )

      if seed.save
        { seed: seed }
      else
        { errors: stack.errors }
      end
    end
  end
end
