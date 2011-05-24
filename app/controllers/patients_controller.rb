class PatientsController < ApplicationController
  
  def show
    @patient = Patient.find(params[:id])
  end
	
  def new
  	@title = "New Patient"
  end

end
