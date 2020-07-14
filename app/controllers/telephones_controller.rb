class TelephonesController < PolyController

  def new
  	@child = Telephone.new
  	super
  end
  	
  def create
    @child  = @parent.telephones.build(resource_params)
    super
  end

  def edit
  	@child = Telephone.find(params[:id])
  	super
  end
  
  def update
  	@child = Telephone.find(params[:id])
    @bandera = @child.update_attributes(resource_params)
    super
  end

  def destroy
  	@child = Telephone.find(params[:id])
    super
  end

  private
    # Paramaters that can be changed in the web forms
    def resource_params
      params.require(:telephone).permit(:place, :number)
    end
end
