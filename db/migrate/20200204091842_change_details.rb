class ChangeDetails < ActiveRecord::Migration[6.0]
  def change
    rename_column :seeds, :type, :produce_type
    rename_column :products, :type, :produce_type
  end
end
