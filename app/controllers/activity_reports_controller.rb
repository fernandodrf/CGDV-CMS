class ActivityReportsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!	

  def index
  	@activity_reports = []
  	if !current_user.volunteer_id.nil?
  	  if current_user.admin?
  	  	@search = ActivityReport.search(params[:q])
  	  	@activity_reports = @search.result.order('semana DESC').page(params[:page]).per(10)
  	  else
  	  	@search = ActivityReport.where(:volunteer_id => current_user.volunteer_id).search(params[:q])
  	  	@activity_reports = @search.result.order('semana DESC').page(params[:page]).per(10)
  	  	if @activity_reports.nil?
  	  	  @activity_reports = []
  	  	end
  	  end
  	end
    @title = "Reportes de Actividades"
  end

  def show
    @activity_report = ActivityReport.find(params[:id])
    @comments = @activity_report.comments
  end

  def new
    @activity_report = ActivityReport.new
    @activity_report.volunteer_id = getvolunteerid
    @title = "Reportes de Actividades"
  end

  def create
    @activity_report = ActivityReport.new(params[:activity_report])
    @activity_report.volunteer_id = getvolunteerid
    puts @activity_report
    if @activity_report.save
      flash[:success] = t('flash.success.create', :model => "Reportes de Actividades")
      redirect_to @activity_report
    else
      render :action => 'new'
    end
  end

  def edit
    @activity_report = ActivityReport.find(params[:id])
	@title = "Reportes de Actividades"
  end

  def update
    @activity_report = ActivityReport.find(params[:id])
    if @activity_report.update_attributes(params[:activity_report])
      flash[:success] = t('flash.success.edit', :model => "Reportes de Actividades")
      redirect_to @activity_report
    else
      render :action => 'edit'
    end
  end

  def destroy
    @activity_report = ActivityReport.find(params[:id])
    @activity_report.destroy
    flash[:success] = t('flash.success.destroy', :model => "Reportes de Actividades")
    redirect_to activity_reports_url
  end
  
  private
  
    def getvolunteerid
      id = !current_user.volunteer_id.nil? ? current_user.volunteer_id : nil
      return id
    end
end
