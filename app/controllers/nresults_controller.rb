class NresultsController < ApplicationController

  before_filter :login_required
  before_filter :is_admin
  
  def is_admin
    self.current_user.login == "admin" ? true:access_denied
  end

  layout "home"
  # GET /nresults
  # GET /nresults.xml
  def index
    @tracks = Track.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tracks }
    end
  end

  # GET /nresults/1
  # GET /nresults/1.xml
  def show
    @nresult = Nresult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @nresult }
    end
  end

  # GET /nresults/new
  # GET /nresults/new.xml
  def new
    @tracks = Track.all
    @pilots = Pilot.all
    
    @updated = 0
    
    @duplicates = ""
    
    @tracks.each do |track|
      @pilots.each do |pilot|
        @nr_cnt = Nresult.count(:conditions=>{:id_track=>track.id, :id_pilot=>pilot.id});
        if @nr_cnt == 0
          @nresult = Nresult.new
          @nresult.id_track = track.id
          @nresult.id_pilot = pilot.id
          
          @nresult.save
          
          @updated += 1
        elsif @nr_cnt > 1
          @duplicates += "id_track:"+track.id+" id_pilot:"+pilot.id+"<br>\n"
        end
        
      end
    end
    
    flash[:notice] = "Created "+@updated.to_s+" rows, Duplicated "+@duplicates
    redirect_to nresults_path
    
  end

  # GET /nresults/1/edit
  def edit
    @nresult = Nresult.find(params[:id])
  end

  # PUT /nresults/1
  # PUT /nresults/1.xml
  def update
    @nresult = Nresult.find(params[:id])

    respond_to do |format|
      if @nresult.update_attributes(params[:nresult])
        flash[:notice] = 'Nresult was successfully updated.'
        format.html { redirect_to :controller=>'nresults',:action=>'show_by_track',:id=>@nresult.id_track }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @nresult.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show_by_track
    @nresults = Nresult.find(:all, :order=>"id_pilot", :conditions =>{:id_track => params[:id]})
    
    
  end

end
