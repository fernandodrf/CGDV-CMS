class CommentsController < PolyController

  def new
  	@child = Comment.new
  	super
  end
  	
  def create
    @child  = @parent.comments.build(params[:comment])
    super
  end

  def edit
  	@child = Comment.find(params[:id])
  	super
  end
  
  def update
  	@child = Comment.find(params[:id])
    @bandera = @child.update_attributes(params[:comment])
    super
  end

  def destroy
  	@child = Comment.find(params[:id])
  	super
  end
  
end
