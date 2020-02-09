class RemoveSeedsFromStore < ActiveRecord::Migration[6.0]
  def change
    remove_reference :seeds, :store, index: true, foreign_key: true
  end
end
