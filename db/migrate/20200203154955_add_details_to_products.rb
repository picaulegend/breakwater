class AddDetailsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :name, :string
    add_column :products, :value, :decimal
  end
end
