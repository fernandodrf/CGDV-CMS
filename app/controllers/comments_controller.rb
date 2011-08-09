class CommentsController < ApplicationController
 before_filter :authenticate
 before_filter :find_parent

  def new
  	@parent = find_parent
  	@comment = Comment.new
  	@title = t('helpers.submit.create', :model => Comment.to_s)
  end
  	
  def create
  	@parent = find_parent
    @comment  = @parent.comments.build(params[:comment])
    @title = t('helpers.submit.create', :model => Comment.to_s)
    if @comment.save
      flash[:success] = t('flash.success.create', :model => Comment.to_s)
  	  redirect_to @parent
    else
  	  render 'new'
    end
  end

  def edit
  	@parent = find_parent
  	@comment = Comment.find(params[:id])
  	@title = t('helpers.submit.update', :model => Comment.to_s)
  end
  
  def update
  	@parent = find_parent
  	@comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      flash[:success] = t('flash.success.edit', :model => Comment.to_s)
      redirect_to @parent
    else
      @title = t('helpers.submit.create', :model => Comment.to_s)
      render 'edit'
    end
  end

  def destroy
  	@parent = find_parent
  	Comment.find(params[:id]).destroy
    flash[:success] = t('flash.success.destroy', :model => Comment.to_s)
  	redirect_to @parent
  end
  
end
