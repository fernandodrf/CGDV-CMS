class PatientsController < ApplicationController
  include ApplicationHelper
  load_and_authorize_resource	
  before_filter :authenticate
  before_filter :load_info, :only => [:show, :print]
  before_filter :check_status, :only => :update
      
  def index
  	@search = Patient.search(params[:search])
  	@title = t('patient.index')
  	@patients = @search.page(params[:page]).per(10)
  end
  
  def show
  end
  
  def notas
  	@patient = Patient.find(params[:id])
  	@search = @patient.notes.search(params[:search])
  	@notes = @search.page(params[:page]).per(10)
  end
  
  def print 
  	render :layout => false 
  end
	
  def new
  	@patient = Patient.new
  	@cgdvcode = cgdvcode
  	@title = t('helpers.submit.create', :model => Patient.to_s)
  end
  
  def edit
    @patient = Patient.find(params[:id])
    @cgdvcode = @patient.cgdvcode
    @title = t('helpers.submit.update', :model => Patient.to_s)
  end
  
  def create
  	@patient = Patient.new(params[:patient])
  	if @patient.save
  	  flash[:success] = t('flash.success.create', :model => Patient.to_s)
  	  redirect_to @patient
  	else
  	  @title = "New Patient"
  	  @cgdvcode = cgdvcode
  	  render 'new'
  	end
  end
  
  def update
    if @patient.update_attributes(params[:patient])
      flash[:success] = t('flash.success.edit', :model => Patient.to_s)
      redirect_to @patient
    else
      @title = t('helpers.submit.create', :model => Patient.to_s)
      @cgdvcode = @patient.cgdvcode
      render 'edit'
    end
  end
  
  def destroy
    Patient.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Patient.to_s)
    redirect_to patients_path
  end
  
  private

  #Para evitar que los pacientes cambien status de REGLAMENTARIA  
  def check_status	
  	@patient = Patient.find(params[:id])
  	#Si el paciente tiene baja REGLAMENTARIA o es Menor de edad o tiene Adeudo y el usuario no es admin
  	#Reglamentaria
  	reglamentaria = @patient.status == 3
  	#Nuevo Reglamentario
  	reglamentaria_nueva = params[:patient][:status] == '3'
  	#Activo
  	activo = @patient.status == 1
  	#Nuevo Activo
  	activo_nuevo = params[:patient][:status] == '1'  	
  	#menor
  	menor = edad(@patient.birthdate) < 18
  	#Por si no tiene notas

  	adeudos = @patient.notes.empty? ? false : @patient.notes.last.restan > 0.0
    if !current_user.admin?
      error = false
	  if reglamentaria and !reglamentaria_nueva
	    flash[:error] = t('patient.not', :s => "Baja Reglamentaria")
	    error = true
	  end  	
	  if activo and !activo_nuevo and menor
	    flash[:error] = t('patient.not', :s => "Menor de Edad")
	    error = true      	
	  end
	  if activo and !activo_nuevo and adeudos
	    flash[:error] = t('patient.not', :s => "Adeudo")
	    error = true		
	  end	
	  if error
		@title = t('helpers.submit.create', :model => Patient.to_s)
	    @cgdvcode = @patient.cgdvcode
	    render 'edit'
	    return false
	  end
	  
    end
      return true
  end
  
  def load_info
    @patient = Patient.find(params[:id])
    @emails = @patient.emails
    @addinfos = @patient.addinfos
    @telephones = @patient.telephones
    @addresses = @patient.addresses
    @seguros = @patient.derechohabientes
    @apoyos = @patient.apoyos
    @tratamientos = @patient.tratamientos
    @diagnosticos = @patient.diagnosticos
    @refclinica = @patient.refclinica
    @house = @patient.house
    @socioeco = @patient.socioeco
    @familymembers = @patient.family_members.order('created_at ASC')
    @comments = @patient.comments
    @title = @patient.cgdvcode
  end
  
    def cgdvcode
      if Patient.last == nil
  	    @cgdvcode = 1
  	  else
  	    @cgdvcode = Patient.last.cgdvcode + 1
  	  end
    end
end
