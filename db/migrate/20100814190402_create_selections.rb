class CreateSelections < ActiveRecord::Migration
  def self.up
    create_table :selections do |t|
      t.integer :id_user
      t.integer :id_track
      t.integer :id_pilot1
      t.integer :id_pilot2
      t.integer :id_pilot3
      t.integer :id_userteam
      t.boolean :is_bonus
      t.float :pp_point
      t.float :df_point
      t.float :gp_point

      t.timestamps
    end
  end

  def self.down
    drop_table :selections
  end
end
