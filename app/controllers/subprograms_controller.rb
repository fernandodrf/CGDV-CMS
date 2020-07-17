class SubprogramsController < ApplicationController
before_action :authenticate_user!

  def new
  	@volunteer = Volunteer.find(params[:volunteer_id])
  	@subprogram = Subprogram.new
  	@title = t('helpers.submit.create', :model => Subprogram.to_s)
  end
  	
  def create
  	@volunteer = Volunteer.find(params[:volunteer_id])
    @subprogram  = @volunteer.build_subprogram(resource_params)
    @title = t('helpers.submit.create', :model => Subprogram.to_s)
    if @subprogram.save
      flash[:success] = t('flash.success.create', :model => Subprogram.to_s)
  	  redirect_to @volunteer
    else
  	  render 'new'
    end
  end

  def edit
  	@volunteer = Volunteer.find(params[:volunteer_id])
  	@subprogram = Subprogram.find(params[:id])
  	@title = t('helpers.submit.update', :model => Subprogram.to_s)
  end
  
  def update
  	@volunteer = Volunteer.find(params[:volunteer_id])
  	@subprogram = Subprogram.find(params[:id])
    if @subprogram.update_attributes(resource_params)
      flash[:success] = t('flash.success.edit', :model => Subprogram.to_s)
      redirect_to @volunteer
    else
      @title = t('helpers.submit.create', :model => Subprogram.to_s)
      render 'edit'
    end
  end

  def destroy
  	@volunteer = Volunteer.find(params[:volunteer_id])
  	Subprogram.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Subprogram.to_s)
  	redirect_to @volunteer
  end

  private
    def resource_params
      params.require(:subprogram).permit(:donador, :eventos, :hospitales, :suenosdeseos, :fondos,
        :administrativas, :autoayuda, :sobrevivientes, :fugarte, :sobreviviente, :licencia, 
        :exposferias, :disenografico, :abogacia, :invdocumental, :invmedica, :apoyofueraoficina,
        :disenoweb, :apoyocap)
    end
end
