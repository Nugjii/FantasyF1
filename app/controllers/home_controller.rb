class HomeController < ApplicationController
  
  def index
    
    @board = Board.new
    @boards = Board.find(:all, :order => "created_at DESC")
    
    @tracks = Track.find(:all,:order => 'qualify_time ASC', :conditions => ['qualify_time < UTC_TIMESTAMP() '])

  @comingtrack = Track.first(:order => 'qualify_time ASC', :conditions => ['qualify_time > UTC_TIMESTAMP() '])
  
  if (@comingtrack)
    @d_year = @comingtrack.qualify_time.year()
    @d_month = @comingtrack.qualify_time.month()-1
    @d_day = @comingtrack.qualify_time.day()
    @d_hour = @comingtrack.qualify_time.hour()
    @d_minut = @comingtrack.qualify_time.min()
    @d_second = @comingtrack.qualify_time.sec()
  end 
  
    @scorings = VScore.calculate(:sum, "CASE WHEN v_scores.is_bonus THEN all_score*2 ELSE all_score END",  
    :order => 'sum(CASE WHEN v_scores.is_bonus THEN all_score*2 ELSE all_score END) DESC', :group => 'id_user',:having => 'sum(all_score) > 0')
    

  end

  def add_comment
    if(current_user)
      params[:board][:id_user] = current_user.id
    else
      params[:board][:id_user] = nil
    end
    @board = Board.new(params[:board])
    

    respond_to do |format|
      if @board.save
        flash[:notice] = 'Бичлэг амжилттай үүслээ.'
        format.html { redirect_to(:controller=>'home', :action=>'index') }
        format.xml  { render :xml => @board, :status => :created, :location => @board }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @board.errors, :status => :unprocessable_entity }
      end
    end

  end

end
