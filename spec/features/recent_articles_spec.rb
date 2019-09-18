require "rails_helper"

RSpec.feature "Widget management", :type => :feature do
	before(:each) do
		@text_articles = Article.order("updated_at desc")
    	@text_articles = @text_articles.where("created_at >= ?", Time.now - 7.days)
	end
  scenario "Correctly displays Articles" do
    visit "/articles"
    expect(page).to have_selector 'h1', text: 'Recent Articles'
    @text_articles=@text_articles[0..19]
    expected_title = @text_articles.map(&:title)
	actual_title = all('td.title').map(&:text)
	expect(actual_title).to eq(expected_title)
  end

  scenario "Correctly filters Articles by publishing status" do
    visit "/articles?status=published"
    @text_articles = @text_articles.where("published_at IS NOT NULL AND published_at < ?", Time.now)
    @text_articles=@text_articles[0..19]
    expected_title = @text_articles.map(&:title)
	actual_title = all('td.title').map(&:text)
	all_displayed_dates = all('td.published-at').map(&:text)
	expected_sorted_dates = all_displayed_dates.sort
	expect(actual_title).to eq(expected_title)
	expect(all_displayed_dates).to eq(expected_sorted_dates)
  end
end
