class TelephonesController < PolyController

  def new
  	@child = Telephone.new
  	super
  end
  	
  def create
    @child  = @parent.telephones.build(params[:telephone])
    super
  end

  def edit
  	@child = Telephone.find(params[:id])
  	super
  end
  
  def update
  	@child = Telephone.find(params[:id])
    @bandera = @child.update_attributes(params[:telephone])
    super
  end

  def destroy
  	@child = Telephone.find(params[:id])
    super
  end

end
