class PagesController < ApplicationController
  def home
  	@title = t('home.title')
  end
  
  def times
  	@title = t('timereports.title')
  end

end
