class RemovePriceFromItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :price
    add_column :stores, :reputation, :decimal
  end
end
