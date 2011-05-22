class PagesController < ApplicationController
  def home
  	@title = "Home"
  end
  
  def patient
  	@title = "Patient"
  end

end
