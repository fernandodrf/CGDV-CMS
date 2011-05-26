class PatientsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :index, :show, :edit, :update]
  
  def index
  	@title = t('patient.index')
  	@patients = Patient.paginate(:page => params[:page])
  end
  
  def show
    @patient = Patient.find(params[:id])
    @title = @patient.cgdvcode
  end
	
  def new
  	@patient = Patient.new
  	@title = t('helpers.submit.create', :model => Patient.to_s)
  end
  
  def edit
    @patient = Patient.find(params[:id])
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
      @title = "Edit Patient"
      render 'edit'
    end
  end
  
  def destroy
    Patient.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Patient.to_s)
    redirect_to patients_path
  end
  
  private

    def authenticate
      deny_access unless signed_in?
    end
end
