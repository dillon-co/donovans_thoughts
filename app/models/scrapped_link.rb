# == Schema Information
#
# Table name: scrapped_links
#
#  id              :integer          not null, primary key
#  link_name       :string
#  google_link     :text
#  scrapped_link   :text
#  search_query_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'

class ScrappedLink < ActiveRecord::Base
  belongs_to :search_query

  def get_text_from_link
    doc = Nokogiri::HTML(open(google_link, :allow_redirections => :all))
    doc.css('script', 'link').each { |node| node.remove }
    return doc.css('body').text.squeeze('\n')
  end  
end
