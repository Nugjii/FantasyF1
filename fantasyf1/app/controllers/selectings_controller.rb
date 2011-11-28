class SelectingsController < ApplicationController
  layout "home" 
  before_filter :login_required
  
  # GET /selectings
  # GET /selectings.xml
  def index
    @selectings = Selecting.find(:all, :conditions => { :id_user => User.find(current_user).id})
    @track = Track.find(:first,:order => 'qualify_time ASC', :conditions => 'qualify_time + interval \'2 days\' > current_timestamp ')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @selectings }
    end
  end

  # GET /selectings/1
  # GET /selectings/1.xml
  def show
    @selecting = Selecting.find(params[:id])
    @track = Track.find(:first,:order => 'qualify_time ASC', :conditions => 'qualify_time + interval \'2 days\' > current_timestamp ')

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @selecting }
    end
  end

  # GET /selectings/new
  # GET /selectings/new.xml
  def new
    @selecting = Selecting.new
    @pilots = Pilot.find(:all)
    @track = Track.find(:first,:order => 'qualify_time ASC', :conditions => 'qualify_time + interval \'2 days\' > current_timestamp ')

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @selecting }
    end
  end

  # GET /selectings/1/edit
#  def edit
#    @selecting = Selecting.find(params[:id])
#    @pilots = Pilot.find(:all)
#  end

  # POST /selectings
  # POST /selectings.xml
  def create
    params[:selecting][:id_user] = User.find(current_user).id
    params[:selecting][:pp_point] = 0
    params[:selecting][:gp_point] = 0
    @track = Track.find(:first,:order => 'qualify_time ASC', :conditions => 'qualify_time + interval \'2 days\' > current_timestamp ')
    params[:selecting][:id_track] = @track.id
    @selecting = Selecting.new(params[:selecting])
    @selectings = Selecting.find(:all, :conditions => { :id_user => User.find(current_user).id})

    is_selected = false 
    @selectings.each do |slctng|
      if slctng.id_track == @track.id
        is_selected = true
      end
    end

    respond_to do |format|
      if @track.qualify_time > Time.new 
        if !is_selected
          if (params[:selecting][:id_gpilot1]!='0') and (params[:selecting][:id_gpilot2]!='0') and (params[:selecting][:id_gpilot3]!='0')
            if (params[:selecting][:id_gpilot1] != params[:selecting][:id_gpilot2])
              if @selecting.save
                flash[:notice] = 'Таавраа амжилттай сонголоо.'
                format.html { redirect_to(@selecting) }
                format.xml  { render :xml => @selecting, :status => :created, :location => @selecting }
              else
                format.html { render :action => "new" }
                format.xml  { render :xml => @selecting.errors, :status => :unprocessable_entity }
              end
            else 
              flash[:notice] = 'Та нэг хэсэгт адилхан нисгэгч сонгосон байна. Ялгаатайг сонгоно уу'
              format.html { redirect_to(new_selecting_path) }
            end
          else
            flash[:notice] = 'Та сонголтоо дутуу хийсэн байна.'
            format.html { redirect_to(new_selecting_path) }
          end
        else
          flash[:notice] = 'Та энэ уралдааны сонголтоо хийсэн байна. Дараагийн уралдааны сонголт эхэлтэл түр хүлээнэ үү.'
          format.html { redirect_to(selectings_path) }
        end
      else
        flash[:notice] = 'Таавар оруулах хугацаа дууссан байна.'
        format.html { redirect_to(selectings_path) }
      end
    end
  end

  # PUT /selectings/1
  # PUT /selectings/1.xml
  #def update
  #  @selecting = Selecting.find(params[:id])
    
  # respond_to do |format|
  #    if @selecting.update_attributes(params[:selecting])
  #      flash[:notice] = 'Selecting was successfully updated.'
  #      format.html { redirect_to(@selecting) }
  #      format.xml  { head :ok }
  #    else
  #      format.html { render :action => "edit" }
  #      format.xml  { render :xml => @selecting.errors, :status => :unprocessable_entity }
  #    end
  #  end
  #end

  # DELETE /selectings/1
  # DELETE /selectings/1.xml
#  def destroy
#    @selecting = Selecting.find(params[:id])
#    @selecting.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(selectings_url) }
#      format.xml  { head :ok }
#    end
#  end
end
