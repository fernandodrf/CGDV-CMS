class ProvidersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :load_info, :only => :show

  def index
  	@search = Provider.ransack(params[:q])
  	@title = t('provider.index')
  	@providers = @search.result.order('cgdvcode DESC').page(params[:page]).per(10)
  end
  
  def show
  end
  
  def print 
    @provider = Provider.find(params[:id])
  	render :layout => false 
  end
	
  def new
  	@provider = Provider.new
  	@title = t('helpers.submit.create', :model => Provider.to_s)
  end
  
  def edit
    @provider = Provider.find(params[:id])
    @title = t('helpers.submit.update', :model => Provider.to_s)
  end
  
  def create
  	@provider = Provider.create(resource_params)
  	if @provider.save
  	  flash[:success] = t('flash.success.create', :model => Provider.to_s)
  	  redirect_to @provider
  	else
  	  @title = "New Provider"
  	  render 'new'
  	end
  end
  
  def update
    @provider = Provider.find(params[:id])
    if @provider.update_attributes(resource_params)
      flash[:success] = t('flash.success.edit', :model => Provider.to_s)
      redirect_to @provider
    else
      @title = t('helpers.submit.create', :model => Provider.to_s)
      render 'edit'
    end
  end
  
  def destroy
    Provider.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Provider.to_s)
    redirect_to providers_path
  end

  private
    # Paramaters that can be changed in the web forms
    def resource_params
      params.require(:provider).permit(:proveedor, :cgdvcode, :name)
    end

    def load_info
      @provider = Provider.find(params[:id])
      @emails = @provider.emails
      @addinfos = @provider.addinfos
      @telephones = @provider.telephones
      @addresses = @provider.addresses
      @comments = @provider.comments
      @title = @provider.proveedor
    end

end
