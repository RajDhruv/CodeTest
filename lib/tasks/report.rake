require 'csv'

desc "Create an author report"
namespace :report do
  task :authors => :environment do
    # Your query here
    sql_query = <<-SQL
    SELECT count(*) from Articles
    SQL

    data = ActiveRecord::Base.connection.execute(sql_query)
    CSV.open('report.csv', "w") do |csv|
      csv << ["Author", "Day", "Total Drafts", "Total Published"];

      # your code here
    end
  end
end
