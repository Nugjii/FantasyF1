class PilotsController < ApplicationController
  before_filter :login_required
  before_filter :is_admin
  
  def is_admin
    self.current_user.login == "admin" ? true:access_denied
  end
  
  # GET /pilots
  # GET /pilots.xml
  def index
    @pilots = Pilot.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pilots }
    end
  end

  # GET /pilots/1
  # GET /pilots/1.xml
  def show
    @pilot = Pilot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pilot }
    end
  end

  # GET /pilots/new
  # GET /pilots/new.xml
  def new
    @pilot = Pilot.new
    @teams = Team.find(:all)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pilot }
    end
  end

  # GET /pilots/1/edit
  def edit
    @pilot = Pilot.find(params[:id])
    @teams = Team.find(:all)
  end

  # POST /pilots
  # POST /pilots.xml
  def create
    @pilot = Pilot.new(params[:pilot])

    respond_to do |format|
      if @pilot.save
        flash[:notice] = 'Pilot was successfully created.'
        format.html { redirect_to(@pilot) }
        format.xml  { render :xml => @pilot, :status => :created, :location => @pilot }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pilot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pilots/1
  # PUT /pilots/1.xml
  def update
    @pilot = Pilot.find(params[:id])

    respond_to do |format|
      if @pilot.update_attributes(params[:pilot])
        flash[:notice] = 'Pilot was successfully updated.'
        format.html { redirect_to(@pilot) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pilot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pilots/1
  # DELETE /pilots/1.xml
  def destroy
    @pilot = Pilot.find(params[:id])
    @pilot.destroy

    respond_to do |format|
      format.html { redirect_to(pilots_url) }
      format.xml  { head :ok }
    end
  end
end
