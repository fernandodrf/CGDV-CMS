class AddressesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_parent

  def new
  	@parent = find_parent
  	@address = Address.new
  	@title = t('helpers.submit.create', :model => Address.to_s)
  end
  	
  def create
  	@parent = find_parent
    @address  = @parent.addresses.build(params[:address])
    @title = t('helpers.submit.create', :model => Address.to_s)
    if @address.save
      flash[:success] = t('flash.success.create', :model => Address.to_s)
  	  redirect_to @parent
    else
  	  render 'new'
    end
  end

  def edit
  	@parent = find_parent
  	@address = Address.find(params[:id])
  	@title = t('helpers.submit.update', :model => Address.to_s)
  end
  
  def update
  	@parent = find_parent
  	@address = Address.find(params[:id])
    if @address.update_attributes(params[:address])
      flash[:success] = t('flash.success.edit', :model => Address.to_s)
      redirect_to @parent
    else
      @title = t('helpers.submit.create', :model => Address.to_s)
      render 'edit'
    end
  end

  def destroy
  	@parent = find_parent
  	Address.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Address.to_s)
  	redirect_to @parent
  end
  
end
