# == Schema Information
#
# Table name: search_queries
#
#  id         :integer          not null, primary key
#  search     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SearchQuery < ActiveRecord::Base
  has_many :scrapped_links

  

  def generate_all_links
    scrapped_link.new(google_url: url_for_google_search)
  end

  def google_search
    q = Google::Search::Web.new query: "Hello world"
    q.take(64).map{ |que| que.uri }
  end  

end
