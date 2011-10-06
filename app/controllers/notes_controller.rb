class NotesController < ApplicationController
  load_and_authorize_resource	
  before_filter :authenticate_user!
      
  def index
  	@search = Note.search(params[:q])
  	@title = t('note.index')
  	@notes = @search.page(params[:page]).per(10)
  end
  
  def show
    @note = Note.find(params[:id])
  end
  
  def print 
    @note = Note.find(params[:id])
  	render :layout => false 
  end
	
  def new
  	@note = Note.new
  	@note.patient_id = 0
    @folio = notefolio
  	@title = t('helpers.submit.create', :model => Note.to_s)
  	6.times { @note.elements.build }
  	#JSON Data
    @adeudo = getadeudo
    @name = getname
  	respond_to do |format|
  	  format.html
      format.json{ render :json => [@adeudo,@name] }
    end
  end
  
  def edit
    @note = Note.find(params[:id])
    @folio = @note.folio
    @title = t('helpers.submit.update', :model => Note.to_s)
  end
  
  def create
  	@note = Note.new(params[:note])
  	if @note.save
  	  @note = calculos(@note)
  	  if @note.save	
  	    flash[:success] = t('flash.success.create', :model => Note.to_s)
  	    redirect_to @note
  	  else
  	    @title = "New Note"
  	    @folio = notefolio
  	    render 'new'
  	  end
  	else
  	  @title = "New Note"
  	  @folio = notefolio
  	  render 'new'
  	end
  end
  
  def update
    @note = Note.find(params[:id])
    @folio = @note.folio
    if @note.update_attributes(params[:note])
      @note = calculos(@note)
      if @note.save	
        flash[:success] = t('flash.success.edit', :model => Note.to_s)
        redirect_to @note
      else
        @title = t('helpers.submit.create', :model => Note.to_s)
        render 'edit'
      end
    else
      @title = t('helpers.submit.create', :model => Note.to_s)
      render 'edit'
    end
  end
  
  def destroy
    Note.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Note.to_s)
    redirect_to notes_path
  end
  
  private
  
    def notefolio
      if Note.last == nil
  	    @folio = 1
  	  else
  	    @folio = Note.last.folio + 1
  	  end	
    end
    
    def getadeudo
      if !params[:id].nil?
  	    Patient.find(params[:id]).notes.last.nil? ? @adeudo = 0 : @adeudo = Patient.find(params[:id]).notes.last.restan
  	  end
    end
    
    def getname
      if !params[:id].nil?
  	    Patient.find(params[:id]).name.nil? ? @name = "" : @name = Patient.find(params[:id]).name
  	  end
    end

	def calculos(note)
	  sub = 0
	  for element in note.elements
	    sub += (element.cuota * element.cantidad)
	  end
	  note.subtotal = sub
	  note.total = note.subtotal + note.adeudo
	  note.restan = note.total - note.acuenta  
	  return note
	end
end
