require 'csv'
desc "Import Articles"
namespace :db do
  task :import => :environment do
    data=CSV.read('articles.csv')
    data=data[1..-1]
    all_user_names=data.map{|x| x[1]}.uniq
    users=User.where("name in (?)",all_user_names)
    data.each do |content|
    	user=users.select{|x| x if x.name==content[1]}.last
    	Article.create author:user, title: content[0], content: content[3], published_at: content[2].to_time
    end
  end
end
