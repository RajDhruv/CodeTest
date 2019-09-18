module ApplicationHelper
	def article_status(article)
		return (article.published_at.nil? || article.published_at > Time.now) ? "draft" : "published" 
	end
	def article_published_date(article)
		return article.published_at.strftime("%Y-%m-%d") if article.published_at 
	end
	def authors_name(articles)
		return articles.collect {|article| article.author.name }.uniq.join(", ")
	end
end
