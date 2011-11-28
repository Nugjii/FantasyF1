class CreateVScores < ActiveRecord::Migration
  def self.up
    create_table :v_scores do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :v_scores
  end
end
