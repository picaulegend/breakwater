class AddItemsToStores < ActiveRecord::Migration[6.0]
  def change
    add_reference :stores, :items, index: true, foreign_key: true
  end
end
