class VolunteersController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate
  before_filter :load_info, :only => :show
  before_filter :check_status, :only => :update

  def index
  	@search = Volunteer.search(params[:search])
  	@title = t('volunteer.index')
  	@volunteers = @search.page(params[:page]).per(10)
  end
  
  def show
  end
  
  def print 
    @volunteer = Volunteer.find(params[:id])
  	render :layout => false 
  end
	
  def new
  	@volunteer = Volunteer.new
  	@volunteer.extravolunteers.build
  	@volunteer.socialservices.build
  	@cgdvcode = cgdvcode
  	@title = t('helpers.submit.create', :model => Volunteer.to_s)
  end
  
  def edit
    @volunteer = Volunteer.find(params[:id])
    @cgdvcode = @volunteer.cgdvcode
    @title = t('helpers.submit.update', :model => Volunteer.to_s)
  end
  
  def create
  	@volunteer = Volunteer.new(params[:volunteer])
  	if @volunteer.save
  	  flash[:success] = t('flash.success.create', :model => Volunteer.to_s)
  	  redirect_to @volunteer
  	else
  	  @title = "New Volunteer"
  	  @cgdvcode = cgdvcode
  	  render 'new'
  	end
  end
  
  def update
    @volunteer = Volunteer.find(params[:id])
    if @volunteer.update_attributes(params[:volunteer])
      flash[:success] = t('flash.success.edit', :model => Volunteer.to_s)
      redirect_to @volunteer
    else
      @title = t('helpers.submit.create', :model => Volunteer.to_s)
      @cgdvcode = @volunteer.cgdvcode
      render 'edit'
    end
  end
  
  def destroy
    Volunteer.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Volunteer.to_s)
    redirect_to volunteers_path
  end

  private
  
  def load_info
    @volunteer = Volunteer.find(params[:id])
    @emails = @volunteer.emails
    @addinfos = @volunteer.addinfos
    @telephones = @volunteer.telephones
    @addresses = @volunteer.addresses
    @comments = @volunteer.comments
    @subprogram = @volunteer.subprogram
    @diagnosticos = @volunteer.diagnosticos
    @dailyschedules = @volunteer.dailyschedules
    @title = @volunteer.name
  end

  def check_status	
    @volunteer = Volunteer.find(params[:id])
    @status = params[:volunteer][:status]
  	#No debe poder cambiar si tiene estatus 1 y cambia y el usuario no es admin.
	if !(@status == '1') and (@volunteer.status == 1) and !current_user.admin?
	  @title = t('helpers.submit.create', :model => Volunteer.to_s)
      flash[:error] = t('patient.not', :s => "Prestador de Servicio Social")		
      @cgdvcode = @volunteer.cgdvcode
      render 'edit'
      return false
    end
    return true
  end
  
    def cgdvcode
      if Volunteer.last == nil
  	    @cgdvcode = 1
  	  else
  	    @cgdvcode = Volunteer.last.cgdvcode + 1
  	  end
    end
end
