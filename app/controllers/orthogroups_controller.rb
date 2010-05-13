class OrthogroupsController < ApplicationController
  # GET /orthogroups
  # GET /orthogroups.xml
  def index
    @orthogroups = Orthogroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orthogroups }
    end
  end

  # GET /orthogroups/1
  # GET /orthogroups/1.xml
  def show
    @orthogroup = Orthogroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orthogroup }
    end
  end

  # GET /orthogroups/new
  # GET /orthogroups/new.xml
  def new
    @orthogroup = Orthogroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orthogroup }
    end
  end

  # GET /orthogroups/1/edit
  def edit
    @orthogroup = Orthogroup.find(params[:id])
  end

  # POST /orthogroups
  # POST /orthogroups.xml
  def create
    @orthogroup = Orthogroup.new(params[:orthogroup])

    respond_to do |format|
      if @orthogroup.save
        flash[:notice] = 'Orthogroup was successfully created.'
        format.html { redirect_to(@orthogroup) }
        format.xml  { render :xml => @orthogroup, :status => :created, :location => @orthogroup }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orthogroup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orthogroups/1
  # PUT /orthogroups/1.xml
  def update
    @orthogroup = Orthogroup.find(params[:id])

    respond_to do |format|
      if @orthogroup.update_attributes(params[:orthogroup])
        flash[:notice] = 'Orthogroup was successfully updated.'
        format.html { redirect_to(@orthogroup) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orthogroup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orthogroups/1
  # DELETE /orthogroups/1.xml
  def destroy
    @orthogroup = Orthogroup.find(params[:id])
    @orthogroup.destroy

    respond_to do |format|
      format.html { redirect_to(orthogroups_url) }
      format.xml  { head :ok }
    end
  end
end
