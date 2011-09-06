class ApoyosController < ApplicationController
  before_filter :authenticate_user!

  def new
  	@patient = Patient.find(params[:patient_id])
  	@apoyo = Apoyo.new
  	@title = t('helpers.submit.create', :model => Patient.to_s)
  end
  	
  def create
  	@patient = Patient.find(params[:patient_id])
    @apoyo  = @patient.apoyos.build(params[:apoyo])
    @title = t('helpers.submit.create', :model => Patient.to_s)
    if @apoyo.save
      flash[:success] = t('flash.success.create', :model => Apoyo.to_s)
  	  redirect_to @patient
    else
  	  render 'new'
    end
  end

  def edit
  	@patient = Patient.find(params[:patient_id])
  	@apoyo = Apoyo.find(params[:id])
  	@title = t('helpers.submit.update', :model => Patient.to_s)
  end
  
  def update
  	@patient = Patient.find(params[:patient_id])
  	@apoyo = Apoyo.find(params[:id])
    if @apoyo.update_attributes(params[:apoyo])
      flash[:success] = t('flash.success.edit', :model => Apoyo.to_s)
      redirect_to @patient
    else
      @title = t('helpers.submit.create', :model => Apoyo.to_s)
      render 'edit'
    end
  end

  def destroy
  	@patient = Patient.find(params[:patient_id])
  	Apoyo.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Apoyo.to_s)
  	redirect_to @patient
  end

end
