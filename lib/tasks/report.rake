require 'csv'

desc "Create an author report"
namespace :db do
  task :report => :environment do
    # Your query here
    sql_query = <<-SQL
    select a.id as user_id, a.name as author_name,b.published_at as published_at from users a right join articles b on(a.id=b.author_id)
    SQL

    data = ActiveRecord::Base.connection.exec_query(sql_query).rows
    CSV.open('report.csv', "w") do |csv|
      csv << ["Author", "Day", "Total Drafts", "Total Published"]
      all_user_ids=data.collect{|x| x[0]}.uniq
      all_user_ids.each do |user_id|
        all_user_data=data.collect{|x| x  if x[0]==user_id}.compact
        draft_count=0
        published_count=0
        all_user_data.each{|article| (article[2].nil? || article[2] > Time.now) ? draft_count+=1 : published_count+=1}
        csv << [all_user_data[0][1], Time.now.to_date, draft_count, published_count]
      end

      # your code here
    end
  end
end
