class AddressesController < ApplicationController
  before_filter :authenticate

  def new
  	@patient = Patient.find(params[:patient_id])
  	@address = Address.new
  	@title = t('helpers.submit.create', :model => Patient.to_s)
  end
  	
  def create
  	@patient = Patient.find(params[:patient_id])
    @address  = @patient.addresses.build(params[:address])
    @title = t('helpers.submit.create', :model => Patient.to_s)
    if @address.save
      flash[:success] = t('flash.success.create', :model => Address.to_s)
  	  redirect_to @patient
    else
  	  render 'new'
    end
  end

  def edit
  	@patient = Patient.find(params[:patient_id])
  	@address = Address.find(params[:id])
  	@title = t('helpers.submit.update', :model => Patient.to_s)
  end
  
  def update
  	@patient = Patient.find(params[:patient_id])
  	@address = Address.find(params[:id])
    if @address.update_attributes(params[:address])
      flash[:success] = t('flash.success.edit', :model => Address.to_s)
      redirect_to @patient
    else
      @title = t('helpers.submit.create', :model => Address.to_s)
      render 'edit'
    end
  end

  def destroy
  	@patient = Patient.find(params[:patient_id])
  	Address.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Address.to_s)
  	redirect_to @patient
  end

end
