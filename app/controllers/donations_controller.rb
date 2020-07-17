class DonationsController < ApplicationController
  load_and_authorize_resource	
  before_action :authenticate_user!
  
  def index
  	@search = Donation.ransack(params[:q])
  	@title = t('donation2.index')
  	@donations = @search.result.order('folio DESC').page(params[:page]).per(10)  	
  end

  def show
    @donation = Donation.find(params[:id])
    @title = t('donation2.title')
  end

  def new
    @donation = Donation.new
	@folio = getfolio
  	@title = t('helpers.submit.create', :model => Donation.to_s)
	#JSON Data
    @name = getname
  	respond_to do |format|
  	  format.html
      format.json{ render :json => [@name] }
    end
  end

  def create
    @donation = Donation.create(resource_params)
    if @donation.save
      flash[:success] = t('flash.success.create', :model => Donation.to_s)
      redirect_to @donation
    else
      render :action => 'new'
    end
  end

  def edit
    @donation = Donation.find(params[:id])
    @folio = @donation.folio
    @title = t('helpers.submit.update', :model => Donation.to_s)
  end

  def update
    @donation = Donation.find(params[:id])
    @folio = @donation.folio
    if @donation.update_attributes(resource_params)
      flash[:success] = t('flash.success.edit', :model => Donation.to_s)
      redirect_to @donation
    else
      render :action => 'edit'
    end
  end

  def destroy
    @donation = Donation.find(params[:id])
    @donation.destroy
    flash[:success] = t('flash.success.destroy', :model => Donation.to_s)
    redirect_to donations_url
  end
  
  private
  private
    # Paramaters that can be changed in the web forms
    def resource_params
      params.require(:donation).permit(:folio, :donor_id, :frecepcion, :tipo, :monto, :transaccion, :finalidad, :motivo)
    end

    def getfolio
      if Donation.last == nil
  	    @folio = 1
  	  else
  	    @folio = Donation.last.folio + 1
  	  end	
    end
    
    def getname
      if !params[:id].nil?
  	    Donor.find(params[:id]).name.nil? ? @name = "" : @name = Donor.find(params[:id]).name
  	  end
    end
    
end
