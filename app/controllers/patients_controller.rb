class PatientsController < ApplicationController
  
  def show
    @patient = Patient.find(params[:id])
    @title = @patient.cgdvcode
  end
	
  def new
  	@patient = Patient.new
  	@title = "New Patient"
  end
  
  def create
  	@patient = Patient.new(params[:patient])
  	if @patient.save
  	  flash[:success] = "Patient Succesfully created."
  	  redirect_to @patient
  	else
  	  @title = "New Patient"
  	  render 'new'
  	end
  end

end
