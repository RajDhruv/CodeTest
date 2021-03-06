class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.integer :author_id
      t.string :title
      t.text :content
      t.datetime :published_at
      t.timestamps
    end
  end
end
