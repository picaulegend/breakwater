class ChangeSeedsOnItemsAgain < ActiveRecord::Migration[6.0]
  def change
    remove_reference :seeds, :items, index: true, foreign_key: true
    add_reference :seeds, :item, index: true, foreign_key: true
  end
end
