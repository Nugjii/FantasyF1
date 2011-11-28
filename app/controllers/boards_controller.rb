class BoardsController < ApplicationController
  layout "home" 
  before_filter :login_required , :except => [:index, :show]
  
  
  # GET /boards
  # GET /boards.xml
  def index
    @boards = Board.find(:all, :order => "created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @boards }
    end
  end

  # GET /boards/1
  # GET /boards/1.xml
  def show
    @board = Board.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @board }
    end
  end

  # GET /boards/new
  # GET /boards/new.xml
  def new
    @board = Board.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @board }
    end
  end

  # GET /boards/1/edit
  def edit
    @board = Board.find(params[:id])
  end

  # POST /boards
  # POST /boards.xml
  def create
    params[:board][:id_user] = User.find(current_user).id
    @board = Board.new(params[:board])
    

    respond_to do |format|
      if @board.save
        flash[:notice] = 'Бичлэг амжилттай үүслээ.'
        format.html { redirect_to(@board) }
        format.xml  { render :xml => @board, :status => :created, :location => @board }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @board.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /boards/1
  # PUT /boards/1.xml
  def update
    @board = Board.find(params[:id])
    if @board.id_user == User.find(current_user).id
      respond_to do |format|
        if @board.update_attributes(params[:board])
          flash[:notice] = 'Амжилттай засвар хийгдлээ.'
          format.html { redirect_to(@board) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @board.errors, :status => :unprocessable_entity }
        end
      end
    else
      flash[:notice] = 'Засвар хийх эрхгүй байна.'
      redirect_to(boards_url)
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.xml
  def destroy
    @board = Board.find(params[:id])
    if @board.id_user == User.find(current_user).id
       @board.destroy
  
      respond_to do |format|
        format.html { redirect_to(boards_url) }
        format.xml  { head :ok }
      end
    else
      flash[:notice] = 'Устгах эрхгүй байна.'
      redirect_to(boards_url)
    end
  end
end
