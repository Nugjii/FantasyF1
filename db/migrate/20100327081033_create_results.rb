class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.integer :id_track
      t.boolean :is_pp
      t.integer :id_pilot
      t.double :score

      t.timestamps
    end
  end

  def self.down
    drop_table :results
  end
end
