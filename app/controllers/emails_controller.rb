class EmailsController < ApplicationController
  before_filter :authenticate

  def new
  	@patient = Patient.find(params[:patient_id])
  	@email = Email.new
  	@title = t('helpers.submit.create', :model => Patient.to_s)
  end
  	
  def create
  	@patient = Patient.find(params[:patient_id])
    @email  = @patient.emails.build(params[:email])
    @title = t('helpers.submit.create', :model => Patient.to_s)
    if @email.save
      flash[:success] = t('flash.success.create', :model => Email.to_s)
  	  redirect_to @patient
    else
  	  render 'new'
    end
  end

  def edit
  	@patient = Patient.find(params[:patient_id])
  	@email = Email.find(params[:id])
  	@title = t('helpers.submit.update', :model => Patient.to_s)
  end
  
  def update
  	@patient = Patient.find(params[:patient_id])
  	@email = Email.find(params[:id])
    if @email.update_attributes(params[:email])
      flash[:success] = t('flash.success.edit', :model => Email.to_s)
      redirect_to @patient
    else
      @title = t('helpers.submit.create', :model => Email.to_s)
      render 'edit'
    end
  end

  def destroy
  	@patient = Patient.find(params[:patient_id])
  	Email.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Email.to_s)
  	redirect_to @patient
  end

end
