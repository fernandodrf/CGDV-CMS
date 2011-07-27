class PatientsController < ApplicationController
  load_and_authorize_resource	
  before_filter :authenticate
      
  def index
  	@search = Patient.search(params[:search])
  	@title = t('patient.index')
  	@patients = @search.page(params[:page]).per(10)
  end
  
  def show
    @patient = Patient.find(params[:id])
    @patientphones = @patient.patientphones
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
  
  def print 
    @patient = Patient.find(params[:id])
    @patientphones = @patient.patientphones
    @addresses = @patient.addresses
    @seguros = @patient.derechohabientes
    @apoyos = @patient.apoyos
    @tratamientos = @patient.tratamientos
    @diagnosticos = @patient.diagnosticos
    @refclinica = @patient.refclinica
    @house = @patient.house
    @socioeco = @patient.socioeco
    @familymembers = @patient.family_members.family_members.order('created_at ASC')
    @comments = @patient.comments
    @title = @patient.cgdvcode
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
    @patient = Patient.find(params[:id])
    if @patient.update_attributes(params[:patient])
      flash[:success] = t('flash.success.edit', :model => Patient.to_s)
      redirect_to @patient
    else
      @title = t('helpers.submit.create', :model => Patient.to_s)
      render 'edit'
    end
  end
  
  def destroy
    Patient.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Patient.to_s)
    redirect_to patients_path
  end
  
  private
    def cgdvcode
      if Patient.last == nil
  	    @cgdvcode = 1
  	  else
  	    @cgdvcode = Patient.last.cgdvcode + 1
  	  end
    end
end
