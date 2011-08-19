class DailyschedulesController < ApplicationController
  before_filter :authenticate

  def new
  	@volunteer = Volunteer.find(params[:volunteer_id])
  	@dailyschedule = Dailyschedule.new
  	@title = t('helpers.submit.create', :model => Dailyschedule.to_s)
  end
  	
  def create
  	@volunteer = Volunteer.find(params[:volunteer_id])
    @dailyschedule  = @volunteer.dailyschedules.build(params[:dailyschedule])
    @title = t('helpers.submit.create', :model => Dailyschedule.to_s)
    if @dailyschedule.save
      flash[:success] = t('flash.success.create', :model => Dailyschedule.to_s)
  	  redirect_to @volunteer
    else
  	  render 'new'
    end
  end

  def edit
  	@volunteer = Volunteer.find(params[:volunteer_id])
  	@dailyschedule = Dailyschedule.find(params[:id])
  	@title = t('helpers.submit.update', :model => Dailyschedule.to_s)
  end
  
  def update
  	@volunteer = Volunteer.find(params[:volunteer_id])
  	@dailyschedule = Dailyschedule.find(params[:id])
    if @dailyschedule.update_attributes(params[:dailyschedule])
      flash[:success] = t('flash.success.edit', :model => Dailyschedule.to_s)
      redirect_to @volunteer
    else
      @title = t('helpers.submit.create', :model => Dailyschedule.to_s)
      render 'edit'
    end
  end

  def destroy
  	@volunteer = Volunteer.find(params[:volunteer_id])
  	Dailyschedule.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Dailyschedule.to_s)
  	redirect_to @volunteer
  end

end
