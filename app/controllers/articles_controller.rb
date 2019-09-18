class ArticlesController < ApplicationController
  include Pagy::Backend

  def index
    @articles = Article.order("updated_at desc")
    @articles = @articles.where("created_at >= ?", Time.now - 7.days)
    @articles = @articles.where("title like ?", "%#{params[:title]}%") unless params[:title].blank?
    @articles = @articles.where(author_id: author_id) unless params[:author_id].blank?
    if params[:status] == "published"
      @articles = @articles.where("published_at IS NOT NULL AND published_at < ?", Time.now)
    elsif params[:status] == "draft"
      @articles = @articles.where("published_at IS NULL OR published_at >= ?", Time.now)
    end
    @pagy, @articles = pagy(@articles)
  end
end
