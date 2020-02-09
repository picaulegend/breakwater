class AddItemToSeeds < ActiveRecord::Migration[6.0]
  def change
    add_reference :seeds, :items, index: true, foreign_key: true
    remove_reference :items, :seed, index: true
  end
end
