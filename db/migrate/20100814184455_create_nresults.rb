class CreateNresults < ActiveRecord::Migration
  def self.up
    create_table :nresults do |t|
      t.integer :id_track
      t.integer :id_pilot
      t.float :pp_score
      t.float :df_score
      t.float :gp_score
      t_float :fast_lap

      t.timestamps
    end
  end

  def self.down
    drop_table :nresults
  end
end
