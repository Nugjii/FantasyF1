class CreatePilots < ActiveRecord::Migration
  def self.up
    create_table :pilots do |t|
      t.string :fname
      t.string :lname
      t.string :img_url
      t.integer :id_team

      t.timestamps
    end
  end

  def self.down
    drop_table :pilots
  end
end
