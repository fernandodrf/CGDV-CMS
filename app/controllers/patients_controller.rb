class PatientsController < ApplicationController
  before_filter :authenticate
  
  def index
  	@title = t('patient.index')
  	@patients = Patient.paginate(:page => params[:page])
  end
  
  def show
    @patient = Patient.find(params[:id])
    @patientphones = @patient.patientphones
    @addresses = @patient.addresses
    @seguros = @patient.derechohabientes
    @apoyos = @patient.apoyos
    @tratamientos = @patient.tratamientos
    @comments = @patient.comments
    @title = @patient.cgdvcode
  end
	
  def new
  	@patient = Patient.new
  	@cgdvcode = Patient.last.cgdvcode + 1
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
  
end
