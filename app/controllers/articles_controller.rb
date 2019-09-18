class ArticlesController < ApplicationController
  include Pagy::Backend
  def index
    title = params[:title]
    status = params[:status]
    author_id = params[:author_id]
    @pagy, @articles = pagy(Article.get_articles(title,status,author_id)) # Fetch Paginated Articles Data From Class Method of Article Class
  end
end
