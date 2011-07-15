class NotesController < ApplicationController
 before_filter :authenticate
      
  def index
  	@search = Note.search(params[:search])
  	@title = t('note.index')
  	#@notes = Note.paginate(:page => params[:page])
  	@notes = @search.paginate(:page => params[:page]) 
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
    @folio = notefolio
  	@title = t('helpers.submit.create', :model => Note.to_s)
  	6.times { @note.elements.build }
  	#JSON Data
    @adeudo = getadeudo
  	respond_to do |format|
  	  format.html
      format.json{ render :json => @adeudo }
    end
  end
  
  def edit
    @note = Note.find(params[:id])
    @folio = @note.folio
    @title = t('helpers.submit.update', :model => Note.to_s)
  end
  
  def create
  	@note = Note.new(params[:note])
  	@note = calculos(@note)
  	if @note.save
  	  flash[:success] = t('flash.success.create', :model => Note.to_s)
  	  redirect_to @note
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
  	    Patient.find(params[:id]).notes.last.nil? ? @adeudo = 0 : @adeudo = Patient.find(params[:id]).notes.last.adeudo
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
