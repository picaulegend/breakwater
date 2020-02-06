class CreateStacks < ActiveRecord::Migration[6.0]
  def change
    create_table :stacks do |t|
      t.string :lighting
      t.string :nutrition
      t.references :farm, null: false, foreign_key: true

      t.timestamps
    end
  end
end
