class EmailsController < PolyController

  def new
  	@child = Email.new
  	super
  end
  	
  def create
    @child  = @parent.emails.build(params[:email])
    super
  end

  def edit
  	@child = Email.find(params[:id])
  	super
  end
  
  def update
  	@child = Email.find(params[:id])
    @bandera = @child.update_attributes(params[:email])
    super
  end

  def destroy
  	@child = Email.find(params[:id])
    super
  end

end
