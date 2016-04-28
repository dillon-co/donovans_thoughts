class AddScrappedLinksToSearchQuery < ActiveRecord::Migration
  def change
    add_reference :scraped_links, :search_query, index: true, foreign_key: true
  end
end
