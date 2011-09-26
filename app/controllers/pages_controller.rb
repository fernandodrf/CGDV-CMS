class PagesController < ApplicationController
  def home
  	@title = t('home.title')
  end
  
  def times
  	@title = t('header.timereport')
  end

end
