class EmailsController < PolyController

  def new
  	@child = Email.new
  	super
  end
  	
  def create
    @child  = @parent.emails.build(resource_params)
    super
  end

  def edit
  	@child = Email.find(params[:id])
  	super
  end
  
  def update
  	@child = Email.find(params[:id])
    @bandera = @child.update_attributes(resource_params)
    super
  end

  def destroy
  	@child = Email.find(params[:id])
    super
  end

  private
    # Paramaters that can be changed in the web forms
    def resource_params
      params.require(:email).permit(:email, :datos)
    end
end
