class ChangeDetailsMisc < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :days_played, :decimal
    add_column :users, :money, :decimal
    add_column :slots, :health, :decimal
    add_column :slots, :nutrition, :decimal
    add_column :slots, :longevity, :decimal
    add_column :slots, :size, :decimal
    add_column :slots, :produce_type, :string
    add_column :slots, :days_required, :decimal
    add_column :slots, :day_of_seeding, :decimal
    add_column :slots, :name, :string
  end
end