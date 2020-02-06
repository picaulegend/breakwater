class AddMoreDetailsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :nutrition, :decimal
    add_column :products, :health, :decimal
    add_column :products, :longevity, :decimal
    add_column :products, :size, :decimal
    add_column :products, :type, :string
  end
end
