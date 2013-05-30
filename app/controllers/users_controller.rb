class UsersController < ApplicationController
  load_and_authorize_resource
  # Added show protection in this case, only the user can see its profile.
  before_filter :authenticate_user!, :only => [:new, :create, :index, :show, :edit, :update]
  before_filter :correct_user, :only => [:show, :edit, :update]
  before_filter :admin_user,   :only => [:new, :create, :index, :destroy]
  # Para actualizar roles
  after_filter :update_roles, :only => [:create, :update]

  def index
    @title = t('user.index')
    @users = User.order('created_at DESC').page(params[:page]).per(10)
  end
	
  def image
  	@user = User.find(params[:id])
    send_file "#{Rails.root}/#{@user.avatar_url}",:disposition => 'inline', :type=>"application/jpg", :x_sendfile=>true
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
	
  def new
  	@user = User.new
    @title = t('helpers.submit.create', :model => User.to_s)
  end

  #This method is being modified so only admins can create new users.
  def create
    @user = User.new(params[:user])
    if @user.save
      #sign_in @user
      flash[:success] = t('flash.success.create', :model => User.to_s)
      #redirect_to @user
      redirect_to root_path
    else
      @title = t('helpers.submit.create', :model => User.to_s)
      render 'new'
    end
  end
  
  def edit
    @title = t('helpers.submit.update', :model => User.to_s)
  end
  
  def update
    @user = User.find(params[:id])
    ###DEVISE
    if params[:user][:password].blank?
    	params[:user].delete(:password)
    	params[:user].delete(:password_confirmation)
	   end
	  ###
    if @user.update_attributes(params[:user])
      flash[:success] = t('flash.success.edit', :model => User.to_s)
      redirect_to @user
    else
      @title = t('helpers.submit.update', :model => User.to_s)
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => User.to_s)
    redirect_to users_path
  end
  
  private
    
    #This method was modified to be overriden by admins.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless (current_user == @user) || current_user.admin?
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    #Para actualziar los roles
    def update_roles
      #logger.debug "ENTRO AL METODO"
      @user = User.find(params[:id])
      #logger.debug "LEYO EL USUARIO"

      #Actualiza roles de usuarios
      params[:ss] == "1" ? @user.add_role!('ss') : @user.remove_role!('ss')
      params[:oficina] == "1" ? @user.add_role!('oficina') : @user.remove_role!('oficina')
      params[:timereport] == "1" ? @user.add_role!('timereport') : @user.remove_role!('timereport')
      params[:managetimereport] == "1" ? @user.add_role!('managetimereport') : @user.remove_role!('managetimereport')
      params[:managedonor] == "1" ? @user.add_role!('managedonor') : @user.remove_role!('managedonor')
      params[:managecontact] == "1" ? @user.add_role!('managecontact') : @user.remove_role!('managecontact')

      #logger.debug "TERMINO METODO DE ACTUALIZAR ROLES"
    end

end
