class AddStoreToSeeds < ActiveRecord::Migration[6.0]
  def change
    add_reference :seeds, :store, foreign_key: true
  end
end
