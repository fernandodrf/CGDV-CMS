class ContactsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!
  before_filter :load_info, :only => :show

  def index
  	@search = Contact.search(params[:q])
  	@title = t('contact.index')
  	@contacts = @search.page(params[:page]).per(10)
  end
  
  def show
  end
  
  def print 
    @contact = Contact.find(params[:id])
  	render :layout => false 
  end
	
  def new
  	@contact = Contact.new
  	@title = t('helpers.submit.create', :model => Contact.to_s)
  end
  
  def edit
    @contact = Contact.find(params[:id])
    @title = t('helpers.submit.update', :model => Contact.to_s)
  end
  
  def create
  	@contact = Contact.new(params[:contact])
  	if @contact.save
  	  flash[:success] = t('flash.success.create', :model => Contact.to_s)
  	  redirect_to @contact
  	else
  	  @title = "New Contact"
  	  render 'new'
  	end
  end
  
  def update
    @contact = Contact.find(params[:id])
    if @contact.update_attributes(params[:contact])
      flash[:success] = t('flash.success.edit', :model => Contact.to_s)
      redirect_to @contact
    else
      @title = t('helpers.submit.create', :model => Contact.to_s)
      render 'edit'
    end
  end
  
  def destroy
    Contact.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Contact.to_s)
    redirect_to contacts_path
  end

  private
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
