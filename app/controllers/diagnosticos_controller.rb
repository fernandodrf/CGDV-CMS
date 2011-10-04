class DiagnosticosController < PolyController

  def new
  	@child = Diagnostico.new
	super
  end
  	
  def create
    @child  = @parent.diagnosticos.build(params[:diagnostico])
    super
  end

  def edit
  	@child = Diagnostico.find(params[:id])
  	super
  end
  
  def update
  	@child = Diagnostico.find(params[:id])
    @bandera = @child.update_attributes(params[:diagnostico])
    super
  end

  def destroy
  	@child = Diagnostico.find(params[:id])
  	super
  end
  
end
