class EmailsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_parent

  def new
  	@parent = find_parent
  	@email = Email.new
  	@title = t('helpers.submit.create', :model => Email.to_s)
  end
  	
  def create
  	@parent = find_parent
    @email  = @parent.emails.build(params[:email])
    @title = t('helpers.submit.create', :model => Email.to_s)
    if @email.save
      flash[:success] = t('flash.success.create', :model => Email.to_s)
  	  redirect_to @parent
    else
  	  render 'new'
    end
  end

  def edit
  	@parent = find_parent
  	@email = Email.find(params[:id])
  	@title = t('helpers.submit.update', :model => Email.to_s)
  end
  
  def update
  	@parent = find_parent
  	@email = Email.find(params[:id])
    if @email.update_attributes(params[:email])
      flash[:success] = t('flash.success.edit', :model => Email.to_s)
      redirect_to @parent
    else
      @title = t('helpers.submit.create', :model => Email.to_s)
      render 'edit'
    end
  end

  def destroy
  	@parent = find_parent
  	Email.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Email.to_s)
  	redirect_to @parent
  end

end
