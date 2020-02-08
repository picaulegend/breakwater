class RemoveStore < ActiveRecord::Migration[6.0]
  def change
    drop_table :store
  end
end
