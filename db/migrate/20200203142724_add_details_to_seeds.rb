class AddDetailsToSeeds < ActiveRecord::Migration[6.0]
  def change
    add_column :seeds, :size, :decimal
    add_column :seeds, :health, :decimal
    add_column :seeds, :nutrition, :decimal
    add_column :seeds, :toxicity, :decimal
    add_column :seeds, :days_required, :decimal
  end
end
