class PolyController < ApplicationController
 before_filter :authenticate_user!
 before_filter :find_parent

  def new
  	@title = t('helpers.submit.create', :model => @child.class.to_s)
  end
  	
  def create
    @title = t('helpers.submit.create', :model => @child.class.to_s)
    if @child.save
      flash[:success] = t('flash.success.create', :model => @child.class.to_s)
  	  redirect_to @parent
    else
  	  render 'new'
    end
  end

  def edit
  	@title = t('helpers.submit.update', :model => @child.class.to_s)
  end
  
  def update
    if @bandera
      flash[:success] = t('flash.success.edit', :model => @child.class.to_s)
      redirect_to @parent
    else
      @title = t('helpers.submit.create', :model => @child.class.to_s)
      render 'edit'
    end
  end

  def destroy
  	@child.destroy
    flash[:success] = t('flash.success.destroy', :model => @child.class.to_s)
  	redirect_to @parent
  end
  
end
