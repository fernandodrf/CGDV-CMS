class ContactsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :load_info, :only => :show

  def index
  	@search = Contact.ransack(params[:q])
  	@title = t('contact.index')
  	@contacts = @search.result.order('created_at DESC').page(params[:page]).per(10)
  end
  
  def show
  end
  
  def print 
    @contact = Contact.find(params[:id])
  	render :layout => false 
  end
	
  def new
  	@contact = Contact.new
  	@title = t('helpers.submit.create', :model => "Contacto")
  end
  
  def edit
    @contact = Contact.find(params[:id])
    @title = t('helpers.submit.update', :model => "Contacto")
  end
  
  def create
  	@contact = Contact.create(resource_params)
  	if @contact.save
  	  flash[:success] = t('flash.success.create', :model => "Contacto")
  	  redirect_to @contact
  	else
  	  @title = "Nuevo Contacto"
  	  render 'new'
  	end
  end
  
  def update
    @contact = Contact.find(params[:id])
    if @contact.update_attributes(resource_params)
      flash[:success] = t('flash.success.edit', :model => "Contacto")
      redirect_to @contact
    else
      @title = t('helpers.submit.create', :model => "Contacto")
      render 'edit'
    end
  end
  
  def destroy
    Contact.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => "Contacto")
    redirect_to contacts_path
  end

  private
    # Paramaters that can be changed in the web forms
    def resource_params
      params.require(:contact).permit(:name, :company, :position, :birth)
    end

  def load_info
    @contact = Contact.find(params[:id])
    @emails = @contact.emails
    @addinfos = @contact.addinfos
    @telephones = @contact.telephones
    @addresses = @contact.addresses
    @comments = @contact.comments
    @title = @contact.name
  end

end
