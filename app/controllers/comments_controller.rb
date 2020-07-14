class CommentsController < PolyController

  def new
  	@child = Comment.new
  	super
  end
  	
  def create
    @child  = @parent.comments.build(resource_params)
    super
  end

  def edit
  	@child = Comment.find(params[:id])
  	super
  end
  
  def update
  	@child = Comment.find(params[:id])
    @bandera = @child.update_attributes(resource_params)
    super
  end

  def destroy
  	@child = Comment.find(params[:id])
  	super
  end
  
  private
    # Paramaters that can be changed in the web forms
    def resource_params
      params.require(:comment).permit(:comment)
    end
end
