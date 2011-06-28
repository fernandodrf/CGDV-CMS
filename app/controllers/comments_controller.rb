class CommentsController < ApplicationController
 before_filter :authenticate

  def new
  	@patient = Patient.find(params[:patient_id])
  	@comment = Comment.new
  	@title = t('helpers.submit.create', :model => Patient.to_s)
  end
  	
  def create
  	@patient = Patient.find(params[:patient_id])
    @comment  = @patient.comments.build(params[:comment])
    @title = t('helpers.submit.create', :model => Patient.to_s)
    if @comment.save
      flash[:success] = t('flash.success.create', :model => Comment.to_s)
  	  redirect_to @patient
    else
  	  render 'new'
    end
  end

  def edit
  	@patient = Patient.find(params[:patient_id])
  	@comment = Comment.find(params[:id])
  	@title = t('helpers.submit.update', :model => Patient.to_s)
  end
  
  def update
  	@patient = Patient.find(params[:patient_id])
  	@comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      flash[:success] = t('flash.success.edit', :model => Comment.to_s)
      redirect_to @patient
    else
      @title = t('helpers.submit.create', :model => Comment.to_s)
      render 'edit'
    end
  end

  def destroy
  	@patient = Patient.find(params[:patient_id])
  	Comment.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Comment.to_s)
  	redirect_to @patient
  end
  
end
