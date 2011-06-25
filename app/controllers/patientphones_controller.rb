class PatientphonesController < ApplicationController
  before_filter :authenticate

  def new
  	@patient = Patient.find(params[:patient_id])
  	@phone = Patientphone.new
  	@title = t('helpers.submit.create', :model => Patient.to_s)
  end
  	
  def create
  	@patient = Patient.find(params[:patient_id])
    @phone  = @patient.patientphones.build(params[:patientphone])
    @title = t('helpers.submit.create', :model => Patient.to_s)
    if @phone.save
      flash[:success] = t('flash.success.create', :model => Patientphone.to_s)
  	  redirect_to @patient
    else
  	  render 'new'
    end
  end

  def edit
  	@patient = Patient.find(params[:patient_id])
  	@phone = Patientphone.find(params[:id])
  	@title = t('helpers.submit.update', :model => Patient.to_s)
  end
  
  def update
  	@patient = Patient.find(params[:patient_id])
  	@phone = Patientphone.find(params[:id])
    if @phone.update_attributes(params[:patientphone])
      flash[:success] = t('flash.success.edit', :model => Patientphone.to_s)
      redirect_to @patient
    else
      @title = t('helpers.submit.create', :model => Patientphone.to_s)
      render 'edit'
    end
  end

  def destroy
  	@patient = Patient.find(params[:patient_id])
  	Patientphone.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Patientphone.to_s)
  	redirect_to @patient
  end

end
