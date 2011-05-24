class PatientsController < ApplicationController
  
  def show
    @patient = Patient.find(params[:id])
    @title = @patient.cgdvcode
  end
	
  def new
  	@title = "New Patient"
  end

end
