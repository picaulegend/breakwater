class AddLongevityToSeeds < ActiveRecord::Migration[6.0]
  def change
    add_column :seeds, :longevity, :decimal
  end
end
