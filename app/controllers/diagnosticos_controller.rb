class DiagnosticosController < PolyController

  def new
  	@child = Diagnostico.new
	super
  end
  	
  def create
    @child  = @parent.diagnosticos.build(resource_params)
    super
  end

  def edit
  	@child = Diagnostico.find(params[:id])
  	super
  end
  
  def update
  	@child = Diagnostico.find(params[:id])
    @bandera = @child.update_attributes(resource_params)
    super
  end

  def destroy
  	@child = Diagnostico.find(params[:id])
  	super
  end
  
  private
    # Paramaters that can be changed in the web forms
    def resource_params
      params.require(:diagnostico).permit(:diagnostico)
    end
end
