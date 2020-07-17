class VolTimesController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  
  def index
  	@search = VolTime.ransack(params[:q])
  	@title = t('header.timereport')
  	@voltimes = @search.result.order('created_at DESC').page(params[:page]).per(15)
  end
  
  def show
    @voltime = VolTime.find(params[:id])
  end
	
  def new
  	@voltime = VolTime.new
  	@title = t('helpers.submit.create', :model => 'timereport.title')
  	#JSON Data
    @name = getname
  	respond_to do |format|
  	  format.html
      format.json{ render :json => [@name] }
    end
  end
  
  def edit
    @voltime = VolTime.find(params[:id])
    @title = t('helpers.submit.update', :model => 'timereport.title')
  end
  
  def create
  	@voltime = VolTime.create(resource_params)
  	if @voltime.save	
  	  flash[:success] = t('flash.success.create', :model => 'timereport.title')
  	  redirect_to @voltime
  	else
  	  @title = t('helpers.submit.create', :model => 'timereport.title')
  	  render 'new'
  	end
  end
  
  def update
    @voltime = VolTime.find(params[:id])
    if @voltime.update_attributes(resource_params)	
      flash[:success] = t('flash.success.edit', :model => 'timereport.title')
      redirect_to @voltime
    else
      @title = t('helpers.submit.create', :model => 'timereport.title')
      render 'edit'
    end
  end
  
  def destroy
    VolTime.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => 'timereport.title')
    redirect_to vol_times_path
  end

  private
    # Paramaters that can be changed in the web forms
    def resource_params
      params.require(:vol_time).permit(:evento, :horas, :volunteer_id)
    end

    def getname
      if !params[:id].nil?
  	    Volunteer.find(params[:id]).name.nil? ? @name = "" : @name = Volunteer.find(params[:id]).name
  	  end
    end

end
