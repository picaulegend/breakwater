class AddItemsToSeeds < ActiveRecord::Migration[6.0]
  def change
    add_reference :seeds, :items, index: true, foreign_key: true
  end
end
