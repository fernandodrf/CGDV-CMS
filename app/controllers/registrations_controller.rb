class RegistrationsController < Devise::RegistrationsController
  #override Reg controller to not allow the creation of new users
  def new
    redirect_to root_path	
  end

  def create
    redirect_to root_path
  end

end
	