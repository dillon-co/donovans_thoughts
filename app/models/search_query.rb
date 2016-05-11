# == Schema Information
#
# Table name: search_queries
#
#  id         :integer          not null, primary key
#  search     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'searchbing'
class SearchQuery < ActiveRecord::Base
  has_many :scrapped_links
  has_one :content_summary
  

  def generate_all_links
    scrapped_link.new(googlre_url: url_for_google_search)
  end

  def web_search
    # web_search = Bing.new(ENV['MICROSOFT_AZURE_KEY'], 50, 'web')
    # results = web_search.search(search)
    # puts results
    BingSearch.account_key = 'C6V4XAf+6z7koV27xY6ZofsmyCxI3nQHXU8Dttky1Do'
    BingSearch.web(search)
  end  

  def scrape_text_from_links
    web_search.map do |search_object|
      url = search_object.url
      article = scrapped_links.new(google_link: url)
      article.get_text_from_link
    end.join(' ')
  end  

  def summarize_content
    content = content_summary.create(original_content: scrape_text_from_links)
    content.summary
  end  
end
