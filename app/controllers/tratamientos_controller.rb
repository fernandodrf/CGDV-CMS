class TratamientosController < ApplicationController
 before_filter :authenticate

  def new
  	@patient = Patient.find(params[:patient_id])
  	@tratamiento = Tratamiento.new
  	@title = t('helpers.submit.create', :model => Patient.to_s)
  end
  	
  def create
  	@patient = Patient.find(params[:patient_id])
    @tratamiento  = @patient.tratamientos.build(params[:tratamiento])
    @title = t('helpers.submit.create', :model => Patient.to_s)
    if @tratamiento.save
      flash[:success] = t('flash.success.create', :model => Tratamiento.to_s)
  	  redirect_to @patient
    else
  	  render 'new'
    end
  end

  def edit
  	@patient = Patient.find(params[:patient_id])
  	@tratamiento = Tratamiento.find(params[:id])
  	@title = t('helpers.submit.update', :model => Patient.to_s)
  end
  
  def update
  	@patient = Patient.find(params[:patient_id])
  	@tratamiento = Tratamiento.find(params[:id])
    if @tratamiento.update_attributes(params[:tratamiento])
      flash[:success] = t('flash.success.edit', :model => Tratamiento.to_s)
      redirect_to @patient
    else
      @title = t('helpers.submit.create', :model => Tratamiento.to_s)
      render 'edit'
    end
  end

  def destroy
  	@patient = Patient.find(params[:patient_id])
  	Tratamiento.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Tratamiento.to_s)
  	redirect_to @patient
  end
  
end
