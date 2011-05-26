class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  before_filter :set_user_language
  
  private
  
    def set_user_language
      I18n.locale = current_user.language if signed_in?
    end

end