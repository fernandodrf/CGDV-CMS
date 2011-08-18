class DiagnosticosController < ApplicationController
  before_filter :authenticate
  before_filter :find_parent

  def new
  	@parent = find_parent
  	@diagnostico = Diagnostico.new
  	@title = t('helpers.submit.create', :model => Diagnostico.to_s)
  end
  	
  def create
  	@parent = find_parent
    @diagnostico  = @parent.diagnosticos.build(params[:diagnostico])
    @title = t('helpers.submit.create', :model => Patient.to_s)
    if @diagnostico.save
      flash[:success] = t('flash.success.create', :model => Diagnostico.to_s)
  	  redirect_to @parent
    else
  	  render 'new'
    end
  end

  def edit
  	@parent = find_parent
  	@diagnostico = Diagnostico.find(params[:id])
  	@title = t('helpers.submit.update', :model => Patient.to_s)
  end
  
  def update
  	@parent = find_parent
  	@diagnostico = Diagnostico.find(params[:id])
    if @diagnostico.update_attributes(params[:diagnostico])
      flash[:success] = t('flash.success.edit', :model => Diagnostico.to_s)
      redirect_to @parent
    else
      @title = t('helpers.submit.create', :model => Diagnostico.to_s)
      render 'edit'
    end
  end

  def destroy
  	@parent = find_parent
  	Diagnostico.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Diagnostico.to_s)
  	redirect_to @parent
  end
  
end
