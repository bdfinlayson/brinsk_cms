class TagsController < ApplicationController
  def index
    @tags = current_user.tags
  end
end
