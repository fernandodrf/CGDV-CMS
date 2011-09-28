class ActivityReportsController < ApplicationController
  def index
    @activity_reports = ActivityReport.all
  end

  def show
    @activity_report = ActivityReport.find(params[:id])
  end

  def new
    @activity_report = ActivityReport.new
  end

  def create
    @activity_report = ActivityReport.new(params[:activity_report])
    if @activity_report.save
      redirect_to @activity_report, :notice => "Successfully created activity report."
    else
      render :action => 'new'
    end
  end

  def edit
    @activity_report = ActivityReport.find(params[:id])
  end

  def update
    @activity_report = ActivityReport.find(params[:id])
    if @activity_report.update_attributes(params[:activity_report])
      redirect_to @activity_report, :notice  => "Successfully updated activity report."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @activity_report = ActivityReport.find(params[:id])
    @activity_report.destroy
    redirect_to activity_reports_url, :notice => "Successfully destroyed activity report."
  end
end
