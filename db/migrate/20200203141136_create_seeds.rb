class CreateSeeds < ActiveRecord::Migration[6.0]
  def change
    create_table :seeds do |t|
      t.references :slot, null: true, foreign_key: true
      t.references :user, null: true, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
