class RemoveItemsFromStores < ActiveRecord::Migration[6.0]
  def change
    remove_reference :items, :stores, index: true, foreign_key: true
    add_reference :items, :store, index: true
  end
end
