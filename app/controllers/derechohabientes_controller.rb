class DerechohabientesController < ApplicationController
  before_filter :authenticate

  def new
  	@patient = Patient.find(params[:patient_id])
  	@seguro = Derechohabiente.new
  	@title = t('helpers.submit.create', :model => Patient.to_s)
  end
  	
  def create
  	@patient = Patient.find(params[:patient_id])
    @seguro  = @patient.derechohabientes.build(params[:derechohabiente])
    @title = t('helpers.submit.create', :model => Patient.to_s)
    if @seguro.save
      flash[:success] = t('flash.success.create', :model => Derechohabiente.to_s)
  	  redirect_to @patient
    else
  	  render 'new'
    end
  end

  def edit
  	@patient = Patient.find(params[:patient_id])
  	@seguro = Derechohabiente.find(params[:id])
  	@title = t('helpers.submit.update', :model => Patient.to_s)
  end
  
  def update
  	@patient = Patient.find(params[:patient_id])
  	@seguro = Derechohabiente.find(params[:id])
    if @seguro.update_attributes(params[:derechohabiente])
      flash[:success] = t('flash.success.edit', :model => Derechohabiente.to_s)
      redirect_to @patient
    else
      @title = t('helpers.submit.create', :model => Derechohabiente.to_s)
      render 'edit'
    end
  end

  def destroy
  	@patient = Patient.find(params[:patient_id])
  	Derechohabiente.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Derechohabiente.to_s)
  	redirect_to @patient
  end

end
