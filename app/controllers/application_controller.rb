class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  before_filter :set_user_language
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = t('session.flash.denied')
    redirect_to root_path
  end

  private
  
    def set_user_language
      I18n.locale = current_user.language if signed_in?
    end

    def find_parent
      case
  	    when params[:patient_id] then Patient.find(params[:patient_id])
  	    when params[:contact_id] then Contact.find(params[:contact_id])
  	    when params[:provider_id] then Provider.find(params[:provider_id])
  	    when params[:volunteer_id] then Volunteer.find(params[:volunteer_id])
  	  end  	
    end

end