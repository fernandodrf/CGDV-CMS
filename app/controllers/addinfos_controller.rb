class AddinfosController < PolyController

  def new
  	@child = Addinfo.new
  	super
  end
  	
  def create
    @child  = @parent.addinfos.build(resource_params)
    super
  end

  def edit
  	@child = Addinfo.find(params[:id])
  	super
  end
  
  def update
  	@child = Addinfo.find(params[:id])
    @bandera = @child.update_attributes(resource_params)
    super
  end

  def destroy
  	@child = Addinfo.find(params[:id])
    super
  end

  private

    def resource_params
      params.require(:addinfo).permit(:tipo, :info)
    end

end
