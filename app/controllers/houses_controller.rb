class HousesController < ApplicationController
before_filter :authenticate_user!

  def new
  	@patient = Patient.find(params[:patient_id])
  	@house = House.new
  	@title = t('helpers.submit.create', :model => Patient.to_s)
  end
  	
  def create
  	@patient = Patient.find(params[:patient_id])
    @house  = @patient.build_house(params[:house])
    @title = t('helpers.submit.create', :model => Patient.to_s)
    if @house.save
      flash[:success] = t('flash.success.create', :model => House.to_s)
  	  redirect_to @patient
    else
  	  render 'new'
    end
  end

  def edit
  	@patient = Patient.find(params[:patient_id])
  	@house = House.find(params[:id])
  	@title = t('helpers.submit.update', :model => Patient.to_s)
  end
  
  def update
  	@patient = Patient.find(params[:patient_id])
  	@house = House.find(params[:id])
    if @house.update_attributes(params[:house])
      flash[:success] = t('flash.success.edit', :model => House.to_s)
      redirect_to @patient
    else
      @title = t('helpers.submit.create', :model => House.to_s)
      render 'edit'
    end
  end

  def destroy
  	@patient = Patient.find(params[:patient_id])
  	House.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => House.to_s)
  	redirect_to @patient
  end
end
