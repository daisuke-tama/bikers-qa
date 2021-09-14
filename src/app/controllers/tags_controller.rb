class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @articles = @tag.articles.includes([:user], [:tag_maps], [:tags], [:rich_text_content])
  end
end
