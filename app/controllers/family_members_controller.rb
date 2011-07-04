class FamilyMembersController < ApplicationController
  before_filter :authenticate

  def new
  	@patient = Patient.find(params[:patient_id])
  	@family_member = FamilyMember.new
  	@title = t('helpers.submit.create', :model => Patient.to_s)
  end
  	
  def create
  	@patient = Patient.find(params[:patient_id])
    @family_member  = @patient.family_members.build(params[:family_member])
    @title = t('helpers.submit.create', :model => Patient.to_s)
    if @family_member.save
      flash[:success] = t('flash.success.create', :model => FamilyMember.to_s)
  	  redirect_to @patient
    else
  	  render 'new'
    end
  end

  def edit
  	@patient = Patient.find(params[:patient_id])
  	@family_member = FamilyMember.find(params[:id])
  	@title = t('helpers.submit.update', :model => Patient.to_s)
  end
  
  def update
  	@patient = Patient.find(params[:patient_id])
  	@family_member = FamilyMember.find(params[:id])
    if @family_member.update_attributes(params[:family_member])
      flash[:success] = t('flash.success.edit', :model => FamilyMember.to_s)
      redirect_to @patient
    else
      @title = t('helpers.submit.create', :model => FamilyMember.to_s)
      render 'edit'
    end
  end

  def destroy
  	@patient = Patient.find(params[:patient_id])
  	FamilyMember.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => FamilyMember.to_s)
  	redirect_to @patient
  end
  
end
