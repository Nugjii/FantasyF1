class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.string :team_name
      t.string :team_img

      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end
