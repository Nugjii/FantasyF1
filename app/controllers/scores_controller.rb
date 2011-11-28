class ScoresController < ApplicationController
  layout "home" 
  
  def index
    @tracks = Track.find(:all,:order => 'qualify_time ASC', :conditions => ['qualify_time < UTC_TIMESTAMP() '])
    
    @scorings = VScore.calculate(:sum, "CASE WHEN v_scores.is_bonus THEN all_score*2 ELSE all_score END", :joins => 'LEFT JOIN users ON v_scores.id_user = users.id LEFT JOIN tracks ON v_scores.id_track = tracks.id', 
    :order => 'sum(CASE WHEN v_scores.is_bonus THEN all_score*2 ELSE all_score END) DESC', :group => 'id_user',:having => 'sum(all_score) > 0')
    
  end

end
