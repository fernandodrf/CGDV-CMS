class RefclinicasController < ApplicationController
before_filter :authenticate_user!

  def new
  	@patient = Patient.find(params[:patient_id])
  	@refclinica = Refclinica.new
  	@title = t('helpers.submit.create', :model => Patient.to_s)
  end
  	
  def create
  	@patient = Patient.find(params[:patient_id])
    @refclinica  = @patient.build_refclinica(params[:refclinica])
    @title = t('helpers.submit.create', :model => Patient.to_s)
    if @refclinica.save
      flash[:success] = t('flash.success.create', :model => Refclinica.to_s)
  	  redirect_to @patient
    else
  	  render 'new'
    end
  end

  def edit
  	@patient = Patient.find(params[:patient_id])
  	@refclinica = Refclinica.find(params[:id])
  	@title = t('helpers.submit.update', :model => Patient.to_s)
  end
  
  def update
  	@patient = Patient.find(params[:patient_id])
  	@refclinica = Refclinica.find(params[:id])
    if @refclinica.update_attributes(params[:refclinica])
      flash[:success] = t('flash.success.edit', :model => Refclinica.to_s)
      redirect_to @patient
    else
      @title = t('helpers.submit.create', :model => Refclinica.to_s)
      render 'edit'
    end
  end

  def destroy
  	@patient = Patient.find(params[:patient_id])
  	Refclinica.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Refclinica.to_s)
  	redirect_to @patient
  end
end
