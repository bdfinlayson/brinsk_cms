class TagsController < ApplicationController
  def index
    @tags = current_user.tags
    @tag = Tag.new
  end

  def create
    @tag = current_user.tags.new(tag_params)
    if @tag.save
      redirect_to tags_path, notice: 'Tag created!'
    else
      redirect_to tags_path, alert: 'Unable to create tag'
    end
  end

  def update
    @tag = Tag.find(params[:id])
    @tag.update(tag_params)
    redirect_to tags_path, notice: 'Tag updated!'
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def destroy
    Tag.find(params[:id]).destroy
    redirect_to tags_path, notice: 'Tag destroyed!'
  end

  private
    def tag_params
      params.require(:tag).permit(:name, :color)
    end
end
