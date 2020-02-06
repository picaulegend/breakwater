class ChangeDetailsToSeeds < ActiveRecord::Migration[6.0]
  def change
    add_column :seeds, :longevity, :decimal
    add_column :seeds, :type, :string
    remove_column :seeds, :size
  end
end
