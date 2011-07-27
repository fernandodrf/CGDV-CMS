class TelephonesController < ApplicationController
  before_filter :authenticate

  def new
  	@patient = Patient.find(params[:patient_id])
  	@phone = Telephone.new
  	@title = t('helpers.submit.create', :model => Patient.to_s)
  end
  	
  def create
  	@patient = Patient.find(params[:patient_id])
    @phone  = @patient.telephones.build(params[:telephone])
    @title = t('helpers.submit.create', :model => Patient.to_s)
    if @phone.save
      flash[:success] = t('flash.success.create', :model => Telephone.to_s)
  	  redirect_to @patient
    else
  	  render 'new'
    end
  end

  def edit
  	@patient = Patient.find(params[:patient_id])
  	@phone = Telephone.find(params[:id])
  	@title = t('helpers.submit.update', :model => Patient.to_s)
  end
  
  def update
  	@patient = Patient.find(params[:patient_id])
  	@phone = Telephone.find(params[:id])
    if @phone.update_attributes(params[:telephone])
      flash[:success] = t('flash.success.edit', :model => Telephone.to_s)
      redirect_to @patient
    else
      @title = t('helpers.submit.create', :model => Telephone.to_s)
      render 'edit'
    end
  end

  def destroy
  	@patient = Patient.find(params[:patient_id])
  	Telephone.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Telephone.to_s)
  	redirect_to @patient
  end

end
