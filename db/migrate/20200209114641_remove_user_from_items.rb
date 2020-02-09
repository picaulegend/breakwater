class RemoveUserFromItems < ActiveRecord::Migration[6.0]
  def change
    remove_reference :items, :user, index: true, foreign_key: true
  end
end
