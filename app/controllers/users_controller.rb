class UsersController < ApplicationController
  # Added show protection in this case, only the user can see its profile.
  before_filter :authenticate, :only => [:new, :create, :index, :show, :edit, :update]
  before_filter :correct_user, :only => [:show, :edit, :update]
  before_filter :admin_user,   :only => [:new, :create, :index, :destroy]

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end
	
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
	
  def new
  	@user = User.new
    @title = "Sign up"
  end

  #This method is being modified so only admins can create new users.
  def create
    @user = User.new(params[:user])
    if @user.save
      #sign_in @user
      flash[:success] = "User succesfully created."
      #redirect_to @user
      redirect_to root_path
    else
      @title = "Sign up"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit user"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  
  private

    def authenticate
      deny_access unless signed_in?
    end
    
    #This method was modified to be overriden by admins.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user) || current_user.admin?
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
