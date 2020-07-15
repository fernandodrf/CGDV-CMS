class DonorsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!
  before_filter :load_info, :only => :show

  def index
  	@search = Donor.search(params[:q])
  	@title = t('donation.index')
  	@donors = @search.result.order('cgdvcode DESC').page(params[:page]).per(15)
  end
  
  def show
  end
	
  def new
  	@donor = Donor.new
  	@donor.extradonors.build
  	@cgdvcode = cgdvcode
  	@title = t('helpers.submit.create', :model => Donor.to_s)
  end
  
  def edit
    @donor = Donor.find(params[:id])
    @cgdvcode = @donor.cgdvcode
    @title = t('helpers.submit.update', :model => Donor.to_s)
  end
  
  def create
  	@donor = Donor.create(resource_params)
  	if @donor.save
  	  flash[:success] = t('flash.success.create', :model => Donor.to_s)
  	  redirect_to @donor
  	else
  	  @title = "New Donor"
  	  @cgdvcode = cgdvcode
  	  render 'new'
  	end
  end
  
  def update
    @donor = Donor.find(params[:id])
    if @donor.update_attributes(resource_params)
      flash[:success] = t('flash.success.edit', :model => Donor.to_s)
      redirect_to @donor
    else
      @title = t('helpers.submit.create', :model => Donor.to_s)
      @cgdvcode = @donor.cgdvcode
      render 'edit'
    end
  end
  
  def destroy
    Donor.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Donor.to_s)
    redirect_to donors_path
  end

  private
    # Paramaters that can be changed in the web forms
    def resource_params
      params.require(:donor).permit(:persona, :cgdvcode, :name, :rfc, :birth, extradonors_attributes: [:id, :pautoriza, :pcontacto, :_destroy])
    end

	def load_info
	  @donor = Donor.find(params[:id])
	  @telephones = @donor.telephones
	  @addresses = @donor.addresses
	  @emails = @donor.emails
	  @comments = @donor.comments
	  @title = @donor.cgdvcode
	end
  
    def cgdvcode
      if Donor.last == nil
  	    @cgdvcode = 1
  	  else
  	    @cgdvcode = Donor.last.cgdvcode + 1
  	  end
    end
end
