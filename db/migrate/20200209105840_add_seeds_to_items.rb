class AddSeedsToItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :seeds, index: true, foreign_key: true
    add_column :items, :amountInStock, :decimal
    add_column :items, :price, :decimal
    remove_column :items, :title
    remove_column :items, :image_url
  end
end
