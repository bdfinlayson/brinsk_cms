class TagsController < ApplicationController
  def index
    @tags = current_user.tags
    @tag = Tag.new

  end

  def create

  end

  private
    def tag_params
      params.require(:tag).permit(:name, :color).merge(user: current_user)
    end
end
