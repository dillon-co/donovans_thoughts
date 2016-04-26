class SearchQuery < ActiveRecord::Base
  has_many :scrapped_links

  def url_for_google_search
    formatted_array = format_query
    full_google_url = 'www.google.com/search?q='
    formatted_array.each { |word| full_google_url << word}
    return full_google_url
  end  

  def format_query
    query_array = search.split(' ')
    query_array[1..-1].each_with_index { |word, index| query_array[index+1] = "+#{word}"}
    query_array
  end  
end
