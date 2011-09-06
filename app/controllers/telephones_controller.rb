class TelephonesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_parent

  def new
  	@parent = find_parent
  	@phone = Telephone.new
  	@title = t('helpers.submit.create', :model => Telephone.to_s)
  end
  	
  def create
  	@parent = find_parent
    @phone  = @parent.telephones.build(params[:telephone])
    @title = t('helpers.submit.create', :model => Telephone.to_s)
    if @phone.save
      flash[:success] = t('flash.success.create', :model => Telephone.to_s)
  	  redirect_to @parent
    else
  	  render 'new'
    end
  end

  def edit
  	@parent = find_parent
  	@phone = Telephone.find(params[:id])
  	@title = t('helpers.submit.update', :model => Telephone.to_s)
  end
  
  def update
  	@parent = find_parent
  	@phone = Telephone.find(params[:id])
    if @phone.update_attributes(params[:telephone])
      flash[:success] = t('flash.success.edit', :model => Telephone.to_s)
      redirect_to @parent
    else
      @title = t('helpers.submit.create', :model => Telephone.to_s)
      render 'edit'
    end
  end

  def destroy
  	@parent = find_parent
  	Telephone.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Telephone.to_s)
  	redirect_to @parent
  end

end
