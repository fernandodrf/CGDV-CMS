class SocioecosController < ApplicationController
before_filter :authenticate_user!

  def new
  	@patient = Patient.find(params[:patient_id])
  	@socioeco = Socioeco.new
  	@title = t('helpers.submit.create', :model => Patient.to_s)
  end
  	
  def create
  	@patient = Patient.find(params[:patient_id])
    @socioeco  = @patient.build_socioeco(resource_params)
    @title = t('helpers.submit.create', :model => Patient.to_s)
    if @socioeco.save
      flash[:success] = t('flash.success.create', :model => Socioeco.to_s)
  	  redirect_to @patient
    else
  	  render 'new'
    end
  end

  def edit
  	@patient = Patient.find(params[:patient_id])
  	@socioeco = Socioeco.find(params[:id])
  	@title = t('helpers.submit.update', :model => Patient.to_s)
  end
  
  def update
  	@patient = Patient.find(params[:patient_id])
  	@socioeco = Socioeco.find(params[:id])
    if @socioeco.update_attributes(resource_params)
      flash[:success] = t('flash.success.edit', :model => Socioeco.to_s)
      redirect_to @patient
    else
      @title = t('helpers.submit.create', :model => Socioeco.to_s)
      render 'edit'
    end
  end

  def destroy
  	@patient = Patient.find(params[:patient_id])
  	Socioeco.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Socioeco.to_s)
  	redirect_to @patient
  end

  private
    # Paramaters that can be changed in the web forms
    def resource_params
      params.require(:socioeco).permit(:ingresos, :gastos, :televisiones, :vehiculos, :nivel, :serviciosurbanos, :televisionpaga, :sgmm)
    end
end
