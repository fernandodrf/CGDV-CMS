class DonationsController < ApplicationController
  load_and_authorize_resource	
  before_filter :authenticate_user!
  
  def index
  	@search = Donation.search(params[:search])
  	@title = t('donation2.index')
  	@donations = @search.page(params[:page]).per(10)  	
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
    @donation = Donation.new(params[:donation])
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
    if @donation.update_attributes(params[:donation])
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
