require "rails_helper"

RSpec.feature "Widget management", :type => :feature do
  scenario "Correctly displays Articles" do
    visit "/articles"
    expect(page).to have_selector 'h1', text: 'Recent Articles'
    @text_articles = Article.order("updated_at desc")
    @text_articles = @text_articles.where("created_at >= ?", Time.now - 7.days)
    @text_articles=@text_articles[0..19]
    expected_title = @text_articles.map(&:title)
	actual_title = all('td.title').map(&:text)
	expect(actual_title).to eq(expected_title)
  end

  scenario "Correctly filters Articles by publishing status" do
    visit "/articles"
  end
end
