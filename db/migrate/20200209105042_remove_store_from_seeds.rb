class RemoveStoreFromSeeds < ActiveRecord::Migration[6.0]
  def change
    remove_reference :stores, :seed, index: true, foreign_key: true
  end
end
