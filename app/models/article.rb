class Article < ApplicationRecord
  belongs_to :author, class_name: User.name
  def self.get_articles(title,status,author_id)
  	current_time = Time.now
  	@articles = self.order("updated_at desc")
    @articles = @articles.where("created_at >= ?", current_time - 7.days)
    @articles = @articles.where("title like ?", "%#{title}%") unless title.blank?
    @articles = @articles.where(author_id: author_id) unless author_id.blank?
    if status == "published"
      @articles = @articles.where("published_at IS NOT NULL AND published_at < ?", current_time)
    elsif status == "draft"
      @articles = @articles.where("published_at IS NULL OR published_at >= ?", current_time)
    end
    return @articles.includes(:author)
  end
end
