class PagesController < ApplicationController
  def home
  	@title = t('home.title')
  end
  
  def patient
  	@title = t('patient.title')
  end

end
