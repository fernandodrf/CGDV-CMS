class TelephonesController < ApplicationController
  before_filter :authenticate
  before_filter :find_telephoneable

  def new
  	@parent = find_telephoneable
  	@phone = Telephone.new
  	@title = t('helpers.submit.create', :model => Patient.to_s)
  end
  	
  def create
  	@parent = find_telephoneable
    @phone  = @parent.telephones.build(params[:telephone])
    @title = t('helpers.submit.create', :model => Patient.to_s)
    if @phone.save
      flash[:success] = t('flash.success.create', :model => Telephone.to_s)
  	  redirect_to @parent
    else
  	  render 'new'
    end
  end

  def edit
  	@parent = find_telephoneable
  	@phone = Telephone.find(params[:id])
  	@title = t('helpers.submit.update', :model => Patient.to_s)
  end
  
  def update
  	@parent = find_telephoneable
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
  	@parent = find_telephoneable
  	Telephone.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Telephone.to_s)
  	redirect_to @parent
  end

  private
    def find_telephoneable
      case
  	    when params[:patient_id] then Patient.find(params[:patient_id])
  	    when params[:contact_id] then Contact.find(params[:contact_id])
  	  end  	
        #@telephoneable = klass.find(params[:telephoneable_id])
    end

end
