class AddressesController < PolyController
  
  autocomplete :catestado, :estado, :full => true

  def new
  	@child = Address.new
  	super
  end
  	
  def create
    @child  = @parent.addresses.build(params[:address])
    super
  end

  def edit
  	@child = Address.find(params[:id])
  	super
  end
  
  def update
  	@child = Address.find(params[:id])
    @bandera = @child.update_attributes(params[:address])
    super
  end

  def destroy
  	@child = Address.find(params[:id])
    super
  end
  
end
