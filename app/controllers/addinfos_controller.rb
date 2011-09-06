class AddinfosController < ApplicationController
  before_filter [:authenticate_user!, :find_parent]

  def new
  	@parent = find_parent
  	@addinfo = Addinfo.new
  	@title = t('helpers.submit.create', :model => Addinfo.to_s)
  end
  	
  def create
  	@parent = find_parent
    @addinfo  = @parent.addinfos.build(params[:addinfo])
    @title = t('helpers.submit.create', :model => Addinfo.to_s)
    if @addinfo.save
      flash[:success] = t('flash.success.create', :model => Addinfo.to_s)
  	  redirect_to @parent
    else
  	  render 'new'
    end
  end

  def edit
  	@parent = find_parent
  	@addinfo = Addinfo.find(params[:id])
  	@title = t('helpers.submit.update', :model => Addinfo.to_s)
  end
  
  def update
  	@parent = find_parent
  	@addinfo = Addinfo.find(params[:id])
    if @addinfo.update_attributes(params[:addinfo])
      flash[:success] = t('flash.success.edit', :model => Addinfo.to_s)
      redirect_to @parent
    else
      @title = t('helpers.submit.create', :model => Addinfo.to_s)
      render 'edit'
    end
  end

  def destroy
  	@parent = find_parent
  	Addinfo.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Addinfo.to_s)
  	redirect_to @parent
  end

end
