class TagsController < ApplicationController
  before_action :set_task, only: %i[ update destroy ]
  
  
  def index
    @tags = Tag.all
    @tag = Tag.new
  end
  
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to request.referer
    else
      redirect_to '/'
    end
  end
  
  def update
    if @tag.update(tag_params)
      redirect_to tags_path
    else
      redirect_to '/'
    end
  end
  
  def destroy
    @tag.destroy
    redirect_to tags_path
  end
  
   private
  
  def set_tag
      @tag = Tag.find(params[:id])
  end
   
  def tag_params
    params.require(:tag).permit(:name)
  end
end
