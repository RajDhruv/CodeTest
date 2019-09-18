class AddIndexToArticles < ActiveRecord::Migration[5.2]
  def change
  	add_index :articles, :title
  	add_index :articles, :author_id
  	add_index :articles, :published_at
  	add_index :articles, [:title, :author_id]
  	add_index :articles, [:title, :published_at]
  	add_index :articles, [:author_id, :published_at]
  	add_index :articles, [:title, :author_id, :published_at]
  end
end
