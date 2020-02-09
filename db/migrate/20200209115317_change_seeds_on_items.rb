class ChangeSeedsOnItems < ActiveRecord::Migration[6.0]
  def change
    remove_reference :items, :seeds, index: true, foreign_key: true
    add_reference :items, :seed, index: true
    rename_column :items, :amountInStock, :amount_in_stock
  end
end
