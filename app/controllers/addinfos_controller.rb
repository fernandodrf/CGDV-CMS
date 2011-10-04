class AddinfosController < PolyController

  def new
  	@child = Addinfo.new
  	super
  end
  	
  def create
    @child  = @parent.addinfos.build(params[:addinfo])
    super
  end

  def edit
  	@child = Addinfo.find(params[:id])
  	super
  end
  
  def update
  	@child = Addinfo.find(params[:id])
    @bandera = @child.update_attributes(params[:addinfo])
    super
  end

  def destroy
  	@child = Addinfo.find(params[:id])
    super
  end

end
