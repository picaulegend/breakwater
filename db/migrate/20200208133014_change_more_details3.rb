class ChangeMoreDetails3 < ActiveRecord::Migration[6.0]
  def change
    add_column :seeds, :produce_type, :string
  end
end
