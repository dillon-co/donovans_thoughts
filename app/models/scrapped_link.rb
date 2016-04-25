require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'

class ScrappedLink < ActiveRecord::Base

  def get_text_from_google_link(scrapper_url)
    doc = Nokogiri::HTML(open(scrapper_url, :allow_redirections => :all))
    doc.css('script', 'link').each { |node| node.remove }
    return doc.css('body').text
  end  

  def get_links_from_google_search
    doc = Nokogiri::HTML(open('https://www.google.com/search?q=fun+adventure+questions&oq=fun+adventure+questions&aqs=chrome..69i57.6532j0j7&sourceid=chrome&ie=UTF-8'))
    link_items = doc.xpath("//h3//a")
    links = link_items.map { |link| link.attribute('href').to_s }.uniq.sort.delete_if {|href| href.empty?}
    natural_links = links.map{ |link| pull_link_from_href(link)}
    natural_links  
  end  

  def create_hash_with_links_and_text
    links_with_text = Hash.new
    get_links_from_google_search.each do |link|
      puts link 
      links_with_text[link] = get_text_from_google_link(link)
    end 
    # links_with_text = get_links_from_google_search.each_with_object(Hash.new) { |link, new_hash| new_hash[link] = get_text_from_google_link(link) } 
    return links_with_text 
  end  

  def pull_link_from_href(link)
    link.split('/url?q=').last.split('&sa=').first
  end  
end
