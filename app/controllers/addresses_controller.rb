class AddressesController < PolyController
  
  autocomplete :catestado, :estado, :full => true

  def new
  	@child = Address.new
  	super
  end
  	
  def create
    @child  = @parent.addresses.create(resource_params)
    super
  end

  def edit
  	@child = Address.find(params[:id])
  	super
  end
  
  def update
  	@child = Address.find(params[:id])
    @bandera = @child.update_attributes(resource_params)
    super
  end

  def destroy
  	@child = Address.find(params[:id])
    super
  end

  private
    # Paramaters that can be changed in the web forms
    def resource_params
      params.require(:address).permit(:place, :codigopostal, :estado, :municipio, :colonia, :domicilio, :country)
    end
  
end
