class CreateSelectings < ActiveRecord::Migration
  def self.up
    create_table :selectings do |t|
      t.integer :id_user
      t.integer :id_track
      t.integer :id_ppilot1
      t.integer :id_ppilot2
      t.integer :id_ppilot3
      t.integer :id_ppilot4
      t.integer :id_ppilot5
      t.integer :id_gpilot1
      t.integer :id_gpilot2
      t.integer :id_gpilot3
      t.integer :id_gpilot4
      t.integer :id_gpilot5
      t.float :pp_point
      t.float :gp_point

      t.timestamps
    end
  end

  def self.down
    drop_table :selectings
  end
end
