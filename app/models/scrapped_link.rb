# == Schema Information
#
# Table name: scrapped_links
#
#  id            :integer          not null, primary key
#  link_name     :string
#  google_link   :text
#  scrapped_link :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'

class ScrappedLink < ActiveRecord::Base
  belongs_to :search_query

  def get_text_from_google_link(scrapper_url)
    doc = Nokogiri::HTML(open(scrapper_url, :allow_redirections => :all))
    doc.css('script', 'link').each { |node| node.remove }
    return doc.css('body').text.squeeze('\n')
  end  

  def get_links_from_google_search
    doc = Nokogiri::HTML(open(google_link))
    link_items = doc.xpath("//h3//a")
    links = link_items.map { |link| link.attribute('href').to_s }.uniq.sort.delete_if {|href| href.empty?}
    natural_links = links.map{ |link| pull_link_from_href(link)}
    natural_links  
  end  

  def create_hash_with_links_and_text
    links_with_text = get_links_from_google_search.each_with_object(Hash.new) { |link, new_hash| new_hash[link] = get_text_from_google_link(link) } 
    return links_with_text 
  end  

  def pull_link_from_href(link)
    # this is taking the link and removing the front '/url?q=' and everything
    # after the '&sa=' because those are added by google and generate 404's
    link.split('/url?q=').last.split('&sa=').first
  end  
end
