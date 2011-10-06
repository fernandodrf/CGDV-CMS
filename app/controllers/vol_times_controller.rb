class VolTimesController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!
  
  def index
  	@search = VolTime.search(params[:q])
  	@title = t('header.timereport')
  	@voltimes = @search.page(params[:page]).per(15)
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
  	@voltime = VolTime.new(params[:vol_time])
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
    if @voltime.update_attributes(params[:vol_time])	
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
  
    def getname
      if !params[:id].nil?
  	    Volunteer.find(params[:id]).name.nil? ? @name = "" : @name = Volunteer.find(params[:id]).name
  	  end
    end

end
