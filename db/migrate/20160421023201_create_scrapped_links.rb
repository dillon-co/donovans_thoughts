class CreateScrappedLinks < ActiveRecord::Migration
  def change
    create_table :scrapped_links do |t|
      t.string :link_name
      t.text :google_link
      t.text :scrapped_link
      t.integer :search_query_id, foreign_key: true
      
      t.timestamps null: false
    end
  end
end
