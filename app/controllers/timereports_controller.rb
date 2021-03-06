class TimereportsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  
  def index
  	@search = Timereport.ransack(params[:q])
  	@title = t('header.timereport')
  	@timereports = @search.result.order('created_at DESC').page(params[:page]).per(15)
  end
  
  def show
    @timereport = Timereport.find(params[:id])
  end
	
  def new
  	@timereport = Timereport.new
  	@title = t('helpers.submit.create', :model => 'timereports.title')
  end
  
  def edit
    @timereport = Timereport.find(params[:id])
    @title = t('helpers.submit.update', :model => 'timereports.title')
  end
  
  def create
  	@timereport = Timereport.create(resource_params)
  	if @timereport.save	
  	  flash[:success] = t('flash.success.create', :model => 'timereports.title')
  	  redirect_to @timereport
  	else
  	  @title = t('helpers.submit.create', :model => 'timereports.title')
  	  render 'new'
  	end
  end
  
  def update
    @timereport = Timereport.find(params[:id])
    if @timereport.update_attributes(resource_params)	
      flash[:success] = t('flash.success.edit', :model => 'timereports.title')
      redirect_to @timereport
    else
      @title = t('helpers.submit.create', :model => 'timereports.title')
      render 'edit'
    end
  end
  
  def destroy
    Timereport.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => 'timereports.title')
    redirect_to timereports_path
  end

  private
    # Paramaters that can be changed in the web forms
    def resource_params
      params.require(:timereport).permit(:day, :begin, :end, :evento, :volunteer_id)
    end
end
