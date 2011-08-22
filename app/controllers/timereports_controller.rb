class TimereportsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate
  
  def index
  	@search = Timereport.search(params[:search])
  	@title = t('header.timereport')
  	@timereports = @search.page(params[:page]).per(10)
  end
  
  def show
    @timereport = Timereport.find(params[:id])
  end
	
  def new
  	@timereport = Timereport.new
  	@title = t('helpers.submit.create', :model => Timereport.to_s)
  end
  
  def edit
    @timereport = Timereport.find(params[:id])
    @title = t('helpers.submit.update', :model => Timereport.to_s)
  end
  
  def create
  	@timereport = Timereport.new(params[:timereport])
  	if @timereport.save	
  	  flash[:success] = t('flash.success.create', :model => Timereport.to_s)
  	  redirect_to @timereport
  	else
  	  @title = t('helpers.submit.create', :model => Timereport.to_s)
  	  render 'new'
  	end
  end
  
  def update
    @timereport = Timereport.find(params[:id])
    if @timereport.update_attributes(params[:timereport])	
      flash[:success] = t('flash.success.edit', :model => Timereport.to_s)
      redirect_to @timereport
    else
      @title = t('helpers.submit.create', :model => Timereport.to_s)
      render 'edit'
    end
  end
  
  def destroy
    Timereport.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Timereport.to_s)
    redirect_to timereports_path
  end

end
