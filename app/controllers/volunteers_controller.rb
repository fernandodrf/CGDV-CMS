class VolunteersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :load_info, :only => :show
  before_action :check_status, :only => :update

  def index
  	@search = Volunteer.ransack(params[:q])
  	@title = t('volunteer.index')
  	@volunteers = @search.result.order('cgdvcode DESC').page(params[:page]).per(15)
  end
  
  def image
  	@volunteer = Volunteer.find(params[:id])
    send_file "#{Rails.root}#{@volunteer.avatar_url}",:disposition => 'inline', :type=>"application/jpg", :x_sendfile=>true
  end
  
  
  def show
  end
  
  def trep
  	@volunteer = Volunteer.find(params[:id])
  	@timereports = @volunteer.timereports
  	@voltimes = @volunteer.vol_times
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
  	#JSON Data
    @name = getname
  	respond_to do |format|
  	  format.html
      format.json{ render :json => [@name] }
    end
  end
  
  def edit
    @volunteer = Volunteer.find(params[:id])
    @cgdvcode = @volunteer.cgdvcode
    @title = t('helpers.submit.update', :model => Volunteer.to_s)
  end
  
  def create
  	@volunteer = Volunteer.create(resource_params)
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
    if @volunteer.update_attributes(resource_params)
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
    # Paramaters that can be changed in the web forms
    def resource_params
      params.require(:volunteer).permit(:name, :cgdvcode, :blood, :sex, 
        :status, :birth, :avatar, :avatar_cache, :remove_avatar, 
        extravolunteers_attributes: [:id, :profesion, :_destroy], 
        socialservices_attributes: [:id, :escuela, :carrera, :matricula, :semestre, :inicio, :fin, :_destroy],
        subprograms_attributes: [:id, :donador, :eventos, :hospitales, :suenosdeseos, :fondos,
        :administrativas, :autoayuda, :sobrevivientes, :fugarte, :sobreviviente,
        :licencia, :exposferias, :disenografico, :abogacia, :invdocumental,
        :invmedica, :apoyofueraoficina, :_destroy])
    end
  
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
    
    def getname
      if !params[:id].nil?
  	    Volunteer.find(params[:id]).name.nil? ? @name = "" : @name = Volunteer.find(params[:id]).name
  	  end
    end
end
