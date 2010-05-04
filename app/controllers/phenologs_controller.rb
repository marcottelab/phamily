class PhenologsController < ApplicationController
  # GET /phenologs
  # GET /phenologs.xml
  def index
    @phenologs = Phenolog.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @phenologs }
    end
  end

  # GET /phenologs/1
  # GET /phenologs/1.xml
  def show
    @phenolog = Phenolog.find(params[:id], :include => :phenotypes)
    @phenotypes = @phenolog.phenotypes

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @phenolog }
    end
  end

  # GET /phenologs/new
  # GET /phenologs/new.xml
  def new
    @phenolog = Phenolog.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @phenolog }
    end
  end

  # GET /phenologs/1/edit
  def edit
    @phenolog = Phenolog.find(params[:id])
  end

  # POST /phenologs
  # POST /phenologs.xml
  def create
    @phenolog = Phenolog.new(params[:phenolog])

    respond_to do |format|
      if @phenolog.save
        flash[:notice] = 'Phenolog was successfully created.'
        format.html { redirect_to(@phenolog) }
        format.xml  { render :xml => @phenolog, :status => :created, :location => @phenolog }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @phenolog.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /phenologs/1
  # PUT /phenologs/1.xml
  def update
    @phenolog = Phenolog.find(params[:id])

    respond_to do |format|
      if @phenolog.update_attributes(params[:phenolog])
        flash[:notice] = 'Phenolog was successfully updated.'
        format.html { redirect_to(@phenolog) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @phenolog.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /phenologs/1
  # DELETE /phenologs/1.xml
  def destroy
    @phenolog = Phenolog.find(params[:id])
    @phenolog.destroy

    respond_to do |format|
      format.html { redirect_to(phenologs_url) }
      format.xml  { head :ok }
    end
  end
end
