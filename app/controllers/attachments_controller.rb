class AttachmentsController < PolyController

  def new
  	@child = Attachment.new
  	super
  end

  def show
    @att = Attachment.find(params[:id])
    render :layout => false
  end
  
  def image
    @att = Attachment.find(params[:id])
    send_file "#{Rails.root}#{@att.fileattachment_url}",:disposition => 'inline', :type=>"application/jpg", :x_sendfile=>true 
  end
  	
  def create
    @child  = @parent.attachments.create(attachment_params)
    super
  end

  def edit
  	@child = Attachment.find(params[:id])
  	super
  end
  
  def update
  	@child = Attachment.find(params[:id])
    @bandera = @child.update_attributes(attachment_params)
    super
  end

  def destroy
  	@child = Attachment.find(params[:id])
  	super
  end

  private

    def attachment_params
      params.require(:attachment).permit(:name, :fileattachment, :remove_fileattachment)
    end
  
end
