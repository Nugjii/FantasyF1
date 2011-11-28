class SelectionsController < ApplicationController

  layout "home"
  # GET /selections/new
  # GET /selections/new.xml
  def new
    @selection = Selection.new
    @selection.id_user = params[:id_user]
    @selection.id_track = params[:id_track]
    
    @all_tracks = Track.all(:select => "tracks.id, selections.id AS s_id, tracks.qualify_time, selections.is_bonus", :joins => "LEFT JOIN selections ON tracks.id = selections.id_track AND selections.id_user = "+params[:id_user], :order => "qualify_time ASC")

    @notselected = 0
    @all_tracks.each do |track|
      if track.qualify_time < Time.now and track.s_id == nil 
        @notselected += 1
      end
      if track.is_bonus == "1"
        @notselected -= 2
      end
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @selection }
    end
  end

  # GET /selections/1/edit
  def edit
    @selection = Selection.find(params[:id])
    
    if @selection
      @all_tracks = Track.all(:select => "tracks.id, selections.id AS s_id, tracks.qualify_time, selections.is_bonus", :joins => "LEFT JOIN selections ON tracks.id = selections.id_track AND selections.id_user = "+@selection.id_user.to_s, :order => "qualify_time ASC")
  
      @notselected = 0
      @all_tracks.each do |track|
        if track.qualify_time < Time.now and track.s_id == nil 
          @notselected += 1
        end
        if track.is_bonus == "1"
          @notselected -= 2
        end
      end
    end
  end

  # POST /selections
  # POST /selections.xml
  def create
    @selection = Selection.new(params[:selection])
    
    @track = Track.find(params[:selection][:id_track])
    @slct = Selection.first(:conditions=>{:id_track=>params[:selection][:id_track], :id_user=>params[:selection][:id_user]})
    
    @bln1 = (params[:selection][:id_user].to_i != current_user.id and current_user.login != "admin")
    @bln2 = (@track == nil)
    @bln3 = (@track.qualify_time < Time.now and current_user.login != "admin")
    @bln4 = (@slct != nil)
    if @bln1 or @bln2 or @bln3 or @bln4
      flash[:notice] = 'Сонголт оруулахад хоцорсон байна.'
      redirect_to( :controller=>"users", :action=>"show", :id=>current_user.login)
      return
    end 
    
    if params[:selection][:id_pilot1].to_i == params[:selection][:id_pilot2].to_i
      flash[:notice] = 'Ялгаатай нисгэгчдыг сонгоно уу.'
      render :action => "new"
      return
    end

    respond_to do |format|
      if @selection.save
        flash[:notice] = 'Өөрчлөлт амжилттай хадгалагдлаа.'
        format.html { redirect_to( :controller=>"users", :action=>"show", :id=>current_user.login) }
        format.xml  { render :xml => @selection, :status => :created, :location => @selection }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @selection.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /selections/1
  # PUT /selections/1.xml
  def update
    @selection = Selection.find(params[:id])
    
    @track = Track.find(params[:selection][:id_track])
    @slct = Selection.first(:conditions=>{:id_track=>params[:selection][:id_track], :id_user=>params[:selection][:id_user]})
    
    @bln1 = (params[:selection][:id_user].to_i != current_user.id and current_user.login != "admin")
    @bln2 = (@track == nil)
    @bln3 = (@track.qualify_time < Time.now and current_user.login != "admin")
    @bln4 = (@slct == nil)
    @bln5 = @slct.id != @selection.id
    if @bln1 or @bln2 or @bln3 or @bln4 or @bln5
      flash[:notice] = 'Сонголт оруулахад хоцорсон байна.'
      redirect_to( :controller=>"users", :action=>"show", :id=>current_user.login)
      return
    end 

    if params[:selection][:id_pilot1].to_i == params[:selection][:id_pilot2].to_i
      flash[:notice] = 'Ялгаатай нисгэгчдыг сонгоно уу.'
      render :action => "edit"
      return
    end
    
    respond_to do |format|
      if @selection.update_attributes(params[:selection])
        flash[:notice] = 'Өөрчлөлт амжилттай хадгалагдлаа.'
        format.html { redirect_to( :controller=>"users", :action=>"show", :id=>current_user.login) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @selection.errors, :status => :unprocessable_entity }
      end
    end
  end

end
